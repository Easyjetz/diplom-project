# Дипломный проект: Отказоустойчивая инфраструктура в Yandex Cloud

## Требования
1. Сервисный аккаунт с правами editor
2. SSH-ключ для доступа к ВМ
3. Учетные данные Yandex Cloud (cloud_id и folder_id)

## Инфраструктура
- Бастион-хост (публичный доступ)
- 2 веб-сервера (nginx, приватные)
- Сервер Zabbix (мониторинг)
- Сервер Elasticsearch (сбор логов)
- Сервер Kibana (визуализация логов)

## Установка
1. Создать сервисный аккаунт и скачать ключ:
   ```bash
   cp ~/Downloads/authorized_key.json ~/.authorized_key.json
   ```

2. Заменить SSH ключ в terraform/cloud-init.yml на свой

3. Указать cloud_id и folder_id в terraform/variables.tf

4. Инициализировать Terraform:
   ```bash
   cd terraform
   terraform init
   ```

5. Применить конфигурацию:
   ```bash
   terraform apply
   ```

6. Настроить серверы с помощью Ansible:
   ```bash
   cd ../ansible
   ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook site.yml
   ```

## Доступ
- Веб-сайт: через балансировщик (IP создается отдельно)
- Zabbix: http://<public_ip_zabbix>/zabbix
- Kibana: http://<public_ip_kibana>:5601

## Уничтожение инфраструктуры
```bash
cd terraform
terraform destroy
```
