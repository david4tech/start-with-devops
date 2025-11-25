# 🎤 Guía para la Demo en Vivo

## Preparación Previa (antes de la charla)

1. **Ejecutar el script de setup:**
   ```bash
   ./setup-infrastructure.sh
   ```

2. **Subir el código a GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Demo DevOps"
   git branch -M main
   git remote add origin https://github.com/TU-USUARIO/start-with-devops.git
   git push -u origin main
   ```

3. **Crear el Pipeline en AWS Console:**
   - Ir a CodePipeline → Create Pipeline
   - Nombre: `DevOpsDemoPipeline`
   - Source: GitHub (Version 2) → Conectar repo
   - Build: CodeBuild → Create project
     - Nombre: `DevOpsDemoBuild`
     - Environment: Managed image, Ubuntu, Standard, nodejs:18
     - Buildspec: Use buildspec file
   - Deploy: CodeDeploy
     - Application: `DevOpsDemoApp`
     - Deployment group: Crear nuevo con Lambda

---

## Durante la Demo (10 minutos)

### Minuto 1-2: Introducción
"Vamos a ver cómo pasar de código a producción automáticamente"

**Mostrar:**
- Estructura del proyecto en VS Code
- `src/index.js` - Lambda simple
- `tests/index.test.js` - Tests básicos

### Minuto 3-4: Explicar Pipeline
"El pipeline tiene 3 etapas automáticas"

**Mostrar en AWS Console:**
- CodePipeline → DevOpsDemoPipeline
- Explicar las 3 etapas:
  1. **Source**: GitHub detecta cambios
  2. **Build**: CodeBuild ejecuta tests
  3. **Deploy**: CodeDeploy actualiza Lambda

### Minuto 5-6: Mostrar buildspec.yml
"Aquí definimos qué hace CodeBuild"

```yaml
phases:
  install:    # Instala dependencias
  pre_build:  # Ejecuta tests
  build:      # Prepara artefactos
```

### Minuto 7-9: Demo en Vivo 🔴
"Ahora vamos a hacer un cambio y verlo desplegarse"

**Editar `src/index.js`:**
```javascript
message: '¡Hola DevOps! Desplegado automáticamente - VERSIÓN 2.0',
version: '2.0.0'
```

**Hacer commit y push:**
```bash
git add src/index.js
git commit -m "Update: versión 2.0"
git push origin main
```

**Mostrar en tiempo real:**
- Pipeline arranca automáticamente
- Build ejecutando tests
- Deploy actualizando Lambda

### Minuto 10: Verificar
"Vamos a probar que funciona"

**Invocar Lambda:**
```bash
aws lambda invoke --function-name DevOpsDemoFunction response.json
cat response.json
```

**Mostrar el resultado:**
```json
{
  "message": "¡Hola DevOps! Desplegado automáticamente - VERSIÓN 2.0",
  "version": "2.0.0"
}
```

---

## 💡 Puntos Clave para Mencionar

1. **Automatización Total**: De `git push` a producción sin tocar nada
2. **Tests Automáticos**: Si fallan, no se despliega
3. **Pipeline as Code**: `buildspec.yml` y `appspec.yml` versionados
4. **Serverless**: Sin servidores que gestionar
5. **GitHub Integration**: No necesitas CodeCommit

---

## 🎯 Mensajes para Cerrar

- "Esto es solo el inicio: puedes agregar más etapas (staging, aprobaciones manuales)"
- "AWS DevTools se integra con tus herramientas favoritas (GitHub, Jira, Slack)"
- "El mismo concepto aplica a contenedores, EC2, ECS, etc."

---

## 🆘 Plan B (si algo falla)

Si el pipeline no arranca:
- Mostrar un pipeline pre-ejecutado
- Explicar los logs de CodeBuild
- Mostrar cómo se vería el error si los tests fallan

Si GitHub no conecta:
- Tener screenshots preparados
- Explicar el proceso de conexión OAuth
