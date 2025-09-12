#!/bin/bash

NAMESPACE="smart-home"

# Проверяем, существует ли namespace
if kubectl get namespace "$NAMESPACE" > /dev/null 2>&1; then
  echo "Namespace ${NAMESPACE} существует"
else
  echo "Namespace ${NAMESPACE} не существует. Создаем его..."
  kubectl create namespace "$NAMESPACE"
  if [ $? -eq 0 ]; then
    echo "Namespace ${NAMESPACE} успешно создан"
  else
    echo "Не удалось создать namespace ${NAMESPACE}.  Проверьте права доступа и попробуйте снова."
    exit 1 
  fi
fi

# Применяем YAML-файлы для ролей
kubectl apply -f smart-home-ns-admin-role.yaml
kubectl apply -f smart-home-ns-developer-role.yaml

echo "Роли smart-home-ns-admin и smart-home-ns-developer созданы и применены в namespace ${NAMESPACE}"
