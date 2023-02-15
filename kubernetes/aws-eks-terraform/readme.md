# Laboratorio Demo Trend Micro - Container Security

### Sobre el proyecto

El archivo Dockerfile tiene todo lo necesario para levantar un contenedor con AWS Cli, kubectl, terraform, y los archivos tf para levantar la infraestructura.

Desde el mismo se levantará un cluster EKS en el tenant de AWS al que se loguee.

Se requiere obtener las API Keys necesarias para Container Security y Smartcheck, estas pueden ser obtenidas por medio de un trial gratuito de 30 días [desde aquí](https://cloudone.trendmicro.com/register), dirigiendonós a la sección de Container Security, creando [un nuevo Cluster](https://cloudone.trendmicro.com/docs/container-security/cluster-add/) y un nuevo Scanner; desde esta misma consola se podrá configurar la política a aplicar por el admission controller en nuestro cluster.

> **Nota:**
> El siguiente proyecto tiene por finalidad levantar rápidamente un ambiente de prueba para testear las funcionalidades de **Trend Micro Cloud One - Container Security**. A los efectos, se emplea una misma plantilla de Terraform donde se levanta un cluster de Kubernetes en AWS y emplean charts de Helm. Levantar recursos en un cluster, en el mismo plan de Terraform no es recomendado y debería ser evitado; pero se emplea por razones de simpleza para un laboratorio rápido.
> De ningúna forma se recomienda utilizar esto en un ambiente productivo ni como deploy final tras pruebas.

# Como implementar

### Crear contenedor

```
# Build del contenedor con los archivos

docker build . -t smartcheck

# Correr contenedor

docker run -it smartcheck
```

### Se requiere usar aws-configure para loguearse con el aws-cli:

```
# Ingresar a la seccion "My Security Credentials" dentro de su cuenta AWS. 
# Crear una access key

aws configure

Default region name: us-east-1
Default output format: json
```

### Levantar todo con terraform

```
# Como se pasan por Dockerfile los archivos necesarios, sólo restaría correr:

terraform init

# Se puede planear para ver los recursos que va a levantar y su output (pedirá las API keys necesarias como variables)
terraform plan

# Nuevamente, pedirá las API keys de Container Security y de Smart Check
terraform apply
```

### Acceder al cluster

```
# Una vez termine de instanciarse, necesitamos aplicar el kubeconfig para poder comunicarnos con kubectl al cluster de kubernetes:

aws eks update-kubeconfig --name eks-v01 --region us-east-1

# Por último, podemos conseguir la URL de acceso a Smartcheck con el siguiente comando:

kubectl get svc proxy --namespace deepsecurity-smartcheck

# Las credenciales por defecto estan configuradas desde Terraform, Administrator    Trend123
```
(si instalamos helm, se puede revisar el output del chart con el siguiente comando: helm status smartcheck -n deepsecurity-smartcheck)

### Probarlo

```
# Se pueden probar las configuraciones de la política del Admission Controller (por ejemplo, bloquear "Privileged Containers" de correr en el clúster), con el archivo test.yaml.

kubectl apply -f test.yaml

# Deberíamos ver que se bloqueo el deploy por el admission webhook.
```

### Limpiar todo

```
# Terminadas las pruebas, sólo resta limpiar toda la infraestructura creada con Terraform

terraform destroy

# Salir del contenedor y detenerlo!
```
