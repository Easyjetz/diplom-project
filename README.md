
#  Дипломная работа по профессии «Системный администратор»

Содержание
==========
* [Задача](#Задача)
* [Инфраструктура](#Инфраструктура)
    * [Сайт](#Сайт)
    * [Мониторинг](#Мониторинг)
    * [Логи](#Логи)
    * [Сеть](#Сеть)
    * [Резервное копирование](#Резервное-копирование)
    * [Дополнительно](#Дополнительно)
* [Выполнение работы](#Выполнение-работы)
* [Критерии сдачи](#Критерии-сдачи)
* [Как правильно задавать вопросы дипломному руководителю](#Как-правильно-задавать-вопросы-дипломному-руководителю) 

---------

## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/) и отвечать минимальным стандартам безопасности: запрещается выкладывать токен от облака в git. Используйте [инструкцию](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials).

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**

## Инфраструктура
Для развёртки инфраструктуры используйте Terraform и Ansible.  

Не используйте для ansible inventory ip-адреса! Вместо этого используйте fqdn имена виртуальных машин в зоне ".ru-central1.internal". Пример: example.ru-central1.internal  - для этого достаточно при создании ВМ указать name=example, hostname=examle !! 

Важно: используйте по-возможности **минимальные конфигурации ВМ**:2 ядра 20% Intel ice lake, 2-4Гб памяти, 10hdd, прерываемая. 

**Так как прерываемая ВМ проработает не больше 24ч, перед сдачей работы на проверку дипломному руководителю сделайте ваши ВМ постоянно работающими.**

Ознакомьтесь со всеми пунктами из этой секции, не беритесь сразу выполнять задание, не дочитав до конца. Пункты взаимосвязаны и могут влиять друг на друга.

Развертка инфраструктуры

![РазверткаИнфрыTerraformСкриншот1](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A0%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D0%BA%D0%B0%D0%98%D0%BD%D1%84%D1%80%D1%8BTerraform%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%821.png)
![РазверткаИнфрыTerraformСкриншот2](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A0%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D1%82%D0%BA%D0%B0%D0%98%D0%BD%D1%84%D1%80%D1%8BTerraform%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%822.png)
![РазвернутаяИнфраструктура](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A0%D0%B0%D0%B7%D0%B2%D0%B5%D1%80%D0%BD%D1%83%D1%82%D0%B0%D1%8F%D0%98%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.png)
![УстановкаСофтаСкриншот1](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0%D0%A1%D0%BE%D1%84%D1%82%D0%B0%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%821.png)
![УстановкаСофтаСкриншот2](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0%D0%A1%D0%BE%D1%84%D1%82%D0%B0%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%822.png)
![УстановкаСофтаСкриншот3](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0%D0%A1%D0%BE%D1%84%D1%82%D0%B0%D0%A1%D0%BA%D1%80%D0%B8%D1%88%D0%BE%D1%823.png)
![УстановкаСофтаСкриншот4](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0%D0%A1%D0%BE%D1%84%D1%82%D0%B0%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%824.png)



### Сайт
Создайте две ВМ в разных зонах, установите на них сервер nginx, если его там нет. ОС и содержимое ВМ должно быть идентичным, это будут наши веб-сервера.

Используйте набор статичных файлов для сайта. Можно переиспользовать сайт из домашнего задания.

Виртуальные машины не должны обладать внешним Ip-адресом, те находится во внутренней сети. Доступ к ВМ по ssh через бастион-сервер. Доступ к web-порту ВМ через балансировщик yandex cloud.

Настройка балансировщика:

1. Создайте [Target Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/target-group), включите в неё две созданных ВМ.

2. Создайте [Backend Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/backend-group), настройте backends на target group, ранее созданную. Настройте healthcheck на корень (/) и порт 80, протокол HTTP.

3. Создайте [HTTP router](https://cloud.yandex.com/docs/application-load-balancer/concepts/http-router). Путь укажите — /, backend group — созданную ранее.

4. Создайте [Application load balancer](https://cloud.yandex.com/en/docs/application-load-balancer/) для распределения трафика на веб-сервера, созданные ранее. Укажите HTTP router, созданный ранее, задайте listener тип auto, порт 80.

Протестируйте сайт
`curl -v <публичный IP балансера>:80` 

Балансировщик 

![ЦелевыегруппыГруппыбекендов](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A6%D0%B5%D0%BB%D0%B5%D0%B2%D1%8B%D0%B5%D0%B3%D1%80%D1%83%D0%BF%D0%BF%D1%8B%D0%93%D1%80%D1%83%D0%BF%D0%BF%D1%8B%D0%B1%D0%B5%D0%BA%D0%B5%D0%BD%D0%B4%D0%BE%D0%B2.png)
![ГруппыБезопасности](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%93%D1%80%D1%83%D0%BF%D0%BF%D1%8B%D0%91%D0%B5%D0%B7%D0%BE%D0%BF%D0%B0%D1%81%D0%BD%D0%BE%D1%81%D1%82%D0%B8.png)
![БалансировщикИHTTPРоутер](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%91%D0%B0%D0%BB%D0%B0%D0%BD%D1%81%D0%B8%D1%80%D0%BE%D0%B2%D1%89%D0%B8%D0%BA%D0%98HTTP%D0%A0%D0%BE%D1%83%D1%82%D0%B5%D1%80.png)

Доступность сайта

![ДоступностьСайтаCurl](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%94%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%BD%D0%BE%D1%81%D1%82%D1%8C%D0%A1%D0%B0%D0%B9%D1%82%D0%B0Curl.png)
![Сайт](https://github.com/Easyjetz/diplom-project/blob/main/screen/%D0%A1%D0%B0%D0%B9%D1%82.png)


### Мониторинг
Создайте ВМ, разверните на ней Zabbix. На каждую ВМ установите Zabbix Agent, настройте агенты на отправление метрик в Zabbix. 

Настройте дешборды с отображением метрик, минимальный набор — по принципу USE (Utilization, Saturation, Errors) для CPU, RAM, диски, сеть, http запросов к веб-серверам. Добавьте необходимые tresholds на соответствующие графики.

### Логи
Cоздайте ВМ, разверните на ней Elasticsearch. Установите filebeat в ВМ к веб-серверам, настройте на отправку access.log, error.log nginx в Elasticsearch.

Создайте ВМ, разверните на ней Kibana, сконфигурируйте соединение с Elasticsearch.

### Сеть
Разверните один VPC. Сервера web, Elasticsearch поместите в приватные подсети. Сервера Zabbix, Kibana, application load balancer определите в публичную подсеть.

Настройте [Security Groups](https://cloud.yandex.com/docs/vpc/concepts/security-groups) соответствующих сервисов на входящий трафик только к нужным портам.

Настройте ВМ с публичным адресом, в которой будет открыт только один порт — ssh.  Эта вм будет реализовывать концепцию  [bastion host]( https://cloud.yandex.ru/docs/tutorials/routing/bastion) . Синоним "bastion host" - "Jump host". Подключение  ansible к серверам web и Elasticsearch через данный bastion host можно сделать с помощью  [ProxyCommand](https://docs.ansible.com/ansible/latest/network/user_guide/network_debug_troubleshooting.html#network-delegate-to-vs-proxycommand) . Допускается установка и запуск ansible непосредственно на bastion host.(Этот вариант легче в настройке)

Исходящий доступ в интернет для ВМ внутреннего контура через [NAT-шлюз](https://yandex.cloud/ru/docs/vpc/operations/create-nat-gateway).

### Резервное копирование
Создайте snapshot дисков всех ВМ. Ограничьте время жизни snaphot в неделю. Сами snaphot настройте на ежедневное копирование.



