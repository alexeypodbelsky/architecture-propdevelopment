#!/bin/bash

CLUSTER_NAME="minikube"
NAMESPACE="smart-home"

create_user() {
    USER=$1
    GROUP=$2
    openssl genrsa -out ${USER}.key 2048
    openssl req -new -key ${USER}.key -out ${USER}.csr -subj "/CN=system:user:${USER}/O=${GROUP}"

    # Создаем самоподписанный сертификат
    openssl x509 -req -days 365 -in ${USER}.csr -signkey ${USER}.key -out ${USER}.crt

    # Настраиваем kubectl для пользователя
    kubectl config set-credentials ${USER} \
        --client-certificate=${USER}.crt \
        --client-key=${USER}.key

    kubectl config set-context ${USER}-context \
        --cluster=${CLUSTER_NAME} \
        --user=${USER} \
        --namespace=${NAMESPACE}

    echo "Пользователь ${USER} создан. Контекст: ${USER}-context"
}

# Создаем пользователей
create_user "user1" "smart_home_administrators_team"
create_user "user2" "smart_home_developers_team"

echo "Готово. Теперь можно использовать: kubectl config use-context <user>-context"

