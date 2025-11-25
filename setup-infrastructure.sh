#!/bin/bash

# Script para crear la infraestructura de la demo
# De la Idea al Despliegue: AWS DevTools

set -e

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-east-1"
FUNCTION_NAME="DevOpsDemoFunction"

echo "🚀 Configurando infraestructura para la demo..."
echo "Account ID: $ACCOUNT_ID"
echo "Region: $REGION"

# 1. Crear rol de ejecución para Lambda
echo "📝 Creando rol de ejecución para Lambda..."
aws iam create-role \
  --role-name lambda-devops-demo-role \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {"Service": "lambda.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }]
  }' 2>/dev/null || echo "Rol ya existe"

aws iam attach-role-policy \
  --role-name lambda-devops-demo-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

# 2. Crear la función Lambda inicial
echo "📦 Creando función Lambda..."
cd src
zip -q function.zip index.js
cd ..

aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --runtime nodejs18.x \
  --role arn:aws:iam::$ACCOUNT_ID:role/lambda-devops-demo-role \
  --handler index.handler \
  --zip-file fileb://src/function.zip 2>/dev/null || echo "Lambda ya existe"

rm src/function.zip

# 3. Crear aplicación CodeDeploy
echo "🚢 Configurando CodeDeploy..."
aws deploy create-application \
  --application-name DevOpsDemoApp \
  --compute-platform Lambda 2>/dev/null || echo "Aplicación CodeDeploy ya existe"

# 4. Crear rol para CodeDeploy
aws iam create-role \
  --role-name codedeploy-lambda-role \
  --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {"Service": "codedeploy.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }]
  }' 2>/dev/null || echo "Rol CodeDeploy ya existe"

aws iam attach-role-policy \
  --role-name codedeploy-lambda-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda

echo ""
echo "✅ Infraestructura base creada!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Sube este código a GitHub"
echo "2. Ve a AWS CodePipeline en la consola"
echo "3. Crea un nuevo pipeline con:"
echo "   - Source: GitHub (conecta tu repo)"
echo "   - Build: CodeBuild (usa buildspec.yml)"
echo "   - Deploy: CodeDeploy (usa DevOpsDemoApp)"
echo ""
echo "🎯 Luego haz un 'git push' y observa la magia!"
