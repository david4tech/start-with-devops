# De la Idea al Despliegue: Primeros Pasos con AWS DevTools

Demo para charla sobre CI/CD con AWS DevTools y GitHub.

## 🎯 Objetivo

Crear un pipeline simple que despliegue una aplicación serverless automáticamente al hacer `git push`.

## 🏗️ Arquitectura

```
GitHub → CodePipeline → CodeBuild (tests) → CodeDeploy → Lambda
```

## 📦 Componentes

- **GitHub**: Repositorio de código
- **CodePipeline**: Orquestación del pipeline
- **CodeBuild**: Ejecución de tests y build
- **CodeDeploy**: Despliegue de Lambda
- **Lambda**: Función serverless (Node.js)

## 🚀 Setup Rápido

### 1. Crear la Lambda manualmente (primera vez)

```bash
aws lambda create-function \
  --function-name DevOpsDemoFunction \
  --runtime nodejs18.x \
  --role arn:aws:iam::ACCOUNT_ID:role/lambda-execution-role \
  --handler index.handler \
  --zip-file fileb://function.zip
```

### 2. Crear el Pipeline

El pipeline se puede crear desde la consola de AWS CodePipeline:

**Source Stage:**
- Provider: GitHub (Version 2)
- Repository: tu-usuario/start-with-devops
- Branch: main

**Build Stage:**
- Provider: CodeBuild
- Buildspec: buildspec.yml

**Deploy Stage:**
- Provider: CodeDeploy
- Application: Lambda
- Deployment Group: DevOpsDemoFunction

### 3. Hacer un cambio y push

```bash
# Modificar src/index.js
git add .
git commit -m "Update: nueva versión"
git push origin main
```

El pipeline se ejecutará automáticamente y desplegará los cambios.

## 📁 Estructura del Proyecto

```
start-with-devops/
├── src/
│   └── index.js          # Lambda function
├── tests/
│   └── index.test.js     # Tests
├── buildspec.yml         # Config CodeBuild
├── appspec.yml           # Config CodeDeploy
├── template.yml          # SAM template
└── package.json          # Dependencias
```

## 🧪 Testing Local

```bash
npm install
npm test
```

## 📝 Notas para la Demo

1. Mostrar el código de la Lambda (simple y claro)
2. Explicar buildspec.yml (fases: install, test, build)
3. Mostrar el pipeline en la consola
4. Hacer un cambio en vivo
5. Ver cómo el pipeline se ejecuta automáticamente
6. Verificar el despliegue de la Lambda

## 🎓 Conceptos Clave

- **CI/CD**: Integración y despliegue continuos
- **Pipeline as Code**: buildspec.yml, appspec.yml
- **Serverless**: Sin gestión de servidores
- **Automatización**: De commit a producción sin intervención manual
