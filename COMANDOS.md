# 📝 Comandos Útiles para la Demo

## Setup Inicial

```bash
# Instalar dependencias
npm install

# Ejecutar tests localmente
npm test

# Crear infraestructura AWS
./setup-infrastructure.sh
```

## Git Commands

```bash
# Inicializar repo
git init
git add .
git commit -m "Initial commit: Demo DevOps"
git branch -M main

# Conectar con GitHub
git remote add origin https://github.com/TU-USUARIO/start-with-devops.git
git push -u origin main

# Hacer cambios durante la demo
git add .
git commit -m "Update: nueva versión"
git push origin main
```

## AWS CLI - Lambda

```bash
# Invocar Lambda
aws lambda invoke \
  --function-name DevOpsDemoFunction \
  --payload '{}' \
  response.json

# Ver respuesta
cat response.json | jq

# Ver logs
aws logs tail /aws/lambda/DevOpsDemoFunction --follow

# Ver versiones
aws lambda list-versions-by-function \
  --function-name DevOpsDemoFunction
```

## AWS CLI - CodePipeline

```bash
# Ver estado del pipeline
aws codepipeline get-pipeline-state \
  --name DevOpsDemoPipeline

# Ver ejecuciones
aws codepipeline list-pipeline-executions \
  --pipeline-name DevOpsDemoPipeline

# Iniciar pipeline manualmente
aws codepipeline start-pipeline-execution \
  --name DevOpsDemoPipeline
```

## AWS CLI - CodeBuild

```bash
# Ver builds
aws codebuild list-builds-for-project \
  --project-name DevOpsDemoBuild

# Ver logs de un build
aws codebuild batch-get-builds \
  --ids BUILD_ID
```

## Testing Local

```bash
# Ejecutar tests con coverage
npm test -- --coverage

# Ejecutar tests en watch mode
npm test -- --watch

# Ejecutar un test específico
npm test -- index.test.js
```

## Limpieza (después de la demo)

```bash
# Eliminar Lambda
aws lambda delete-function --function-name DevOpsDemoFunction

# Eliminar aplicación CodeDeploy
aws deploy delete-application --application-name DevOpsDemoApp

# Eliminar pipeline (desde consola o CLI)
aws codepipeline delete-pipeline --name DevOpsDemoPipeline

# Eliminar proyecto CodeBuild
aws codebuild delete-project --name DevOpsDemoBuild

# Eliminar roles IAM
aws iam detach-role-policy \
  --role-name lambda-devops-demo-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam delete-role --role-name lambda-devops-demo-role

aws iam detach-role-policy \
  --role-name codedeploy-lambda-role \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda
aws iam delete-role --role-name codedeploy-lambda-role
```

## URLs Útiles

- **CodePipeline Console**: https://console.aws.amazon.com/codesuite/codepipeline/pipelines
- **Lambda Console**: https://console.aws.amazon.com/lambda/home
- **CodeBuild Console**: https://console.aws.amazon.com/codesuite/codebuild/projects
- **CodeDeploy Console**: https://console.aws.amazon.com/codesuite/codedeploy/applications
