#!/bin/bash

# Creates a K8S cluster using the values specified in set-env-vars.sh 
# which should be sourced before executing this script.

. ./set-env-vars.sh

echo "Creating cluster $CLUSTER_NAME in region $REGION and zones $ZONES with $NODE_COUNT $NODE_SIZE nodes and $MASTER_SIZE sized master node in DNS zone $DNS_ZONE using state store $KOPS_STATE_STORE."
read -p "Do you want to continue? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

BUCKET_EXISTS=true
S3_CHECK=$(aws s3 ls "s3://${KOPS_BUCKET_NAME}" 2>&1)

#Some sort of error happened with s3 check
if [ $? != 0 ]
then
  NO_BUCKET_CHECK=$(echo $S3_CHECK | grep -c 'NoSuchBucket')
  if [ $NO_BUCKET_CHECK = 1 ]; then

    BUCKET_EXISTS=false

    aws s3api create-bucket --bucket ${KOPS_BUCKET_NAME} --region ${REGION} --create-bucket-configuration LocationConstraint=${REGION}
    aws s3api put-bucket-versioning --bucket ${KOPS_BUCKET_NAME} --versioning-configuration Status=Enabled
    aws s3api put-bucket-encryption --bucket ${KOPS_BUCKET_NAME} --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

  else
    echo "Error checking S3 Bucket"
    echo "$S3_CHECK"
    exit 1
  fi
else
  echo -e "\nBucket ${KOPS_BUCKET_NAME} already exists"
fi

kops create cluster \
--cloud aws \
--kubernetes-version ${KUBERNETES_VER} \
--name ${CLUSTER_NAME} \
--dns public \
--dns-zone ${DNS_ZONE} \
--node-count ${NODE_COUNT} \
--node-size ${NODE_SIZE} \
--zones ${ZONES} \
--cloud-labels="Project=SWFactory,Charge_Code=TBD,Owner=wdrew@governmentcio.com,Environment=Dev" \
--master-size ${MASTER_SIZE} \
--master-count ${MASTER_COUNT} \
--master-zones ${MASTER_ZONES} \
--yes

yes y | ssh-keygen -q -f ~/.ssh/${CLUSTER_NAME}-key -t rsa -N ""

kops create secret --name ${CLUSTER_NAME} sshpublickey admin -i ~/.ssh/${CLUSTER_NAME}-key.pub

kops update cluster ${CLUSTER_NAME} --yes

