# install terraform

### install with curl

```bash
curl github.com/jeromedecoster/terraform/raw/master/install.sh \
    --location \
    --silent \
    | bash
```

### install with wget

```bash
wget github.com/jeromedecoster/terraform/raw/master/install.sh \
    --output-document=- \
    --quiet \
    | bash
```

##### use `--no-color` to disable color

```bash
... | bash --no-color
```
