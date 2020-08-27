# Information / Информация

Скрипт для получения внешнего IP и обновления IP в зоне [Cloudflare](https://cloudflare.com/).

## Install / Установка

Во время установки скрипта необходимо выдать ему права и прописать значения некоторых переменных.

#### Права для скрипта

Для работы скрипта необходимы следующие права:

- `read`
- `test`

#### Описание переменных

- `wanInterface` - имя интерфейса, на котором подключен интернет.
- `cfDebug` - включение / отключение журнала.
- `cfEmail` - логин пользователя в Cloudflare.
- `cfToken` - токен пользователя в Cloudflare (Global API Key).
- `cfDomain` - домен пользователя в Cloudflare.
- `cfZoneID` - **Zone ID** домена.
- `cfDNSID` - ID записи в DNS (см. ниже).
- `cfRecordType` - тип записи в DNS.

#### Получение "cfDNSID"

Чтобы получить значение для переменной `cfDNSID`, необходимо выполнить следующую команду и извлечь содержимое поля `id`:

```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones/API_ZONE_ID/dns_records"  \
-H "X-Auth-Email: USER_EMAIL"                                                     \
-H "X-Auth-Key: USER_TOKEN"                                                       \
-H "Content-Type: application/json" | python -mjson.tool
```

## Donation / Пожертвование

- [Donation Form](https://donation-form.github.io/)
