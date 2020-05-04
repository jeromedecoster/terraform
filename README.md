# install terraform

### install with curl

```bash
curl raw.github.com/jeromedecoster/terraform/master/install.sh \
    --location \
    --silent \
    | bash
```

### install with wget

```bash
wget raw.github.com/jeromedecoster/terraform/master/install.sh \
    --output-document=- \
    --quiet \
    | bash
```

##### use `--no-color` to disable color

```bash
... | bash --no-color
```
