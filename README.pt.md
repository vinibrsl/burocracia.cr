<img src="http://4.bp.blogspot.com/-A3yklQR-X8Q/VhmQKDIknzI/AAAAAAAAAJ8/ymMAMlSzKjM/s1600/burocracia.jpg" align="right" />

# burocracia.cr ![Travis](https://img.shields.io/travis/vnbrs/burocracia.cr.svg) [![Dependencies](https://img.shields.io/badge/dependencies-0-green.svg)](#) [![GitHub license](https://img.shields.io/github/license/vnbrs/burocracia.cr.svg)](https://github.com/vnbrs/burocracia.cr/blob/master/LICENSE) 
> Todas as burocracias brasileiras resolvidas!

burocracia.cr é a Crystal shard sem depdendências para validar, gerar e formatar burocracias brasileiras como CEP, CNPJ, CPF e etc.

## Instalação

Adicione o seguinte no `shard.yml` da sua aplicação:

```yaml
dependencies:
  burocracia:
    github: vnbrs/burocracia.cr
```

## Uso

```crystal
require "burocracia"

Burocracia::CEP.generate
=> "23230133"

Burocracia::CEP.generate(format: true)
=> "71946-192"

Burocracia::CPF.valid?("10880423971")
=> false

Burocracia::CNPJ.format("92583745000149")
=> "92.583.745/0001-49"
```

Leia a documentação completa, em inglês, [aqui](https://vnbrs.github.io/burocracia.cr/Burocracia).

## Contribuindo

1. Faça um fork ( https://github.com/vnbrs/burocracia.cr/fork )
2. Crie sua branch (git checkout -b my-new-feature)
3. Faça commit das suas alterações (git commit -am 'Add some feature')
4. Faça um push para a nova branch (git push origin my-new-feature)
5. Crie um Pull Request

## Contribuidores

- [vnbrs](https://github.com/vnbrs) Vinicius Brasil - criador, mantenedor
