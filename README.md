<img src="http://4.bp.blogspot.com/-A3yklQR-X8Q/VhmQKDIknzI/AAAAAAAAAJ8/ymMAMlSzKjM/s1600/burocracia.jpg" align="right" />

# burocracia.cr [![Dependencies](https://img.shields.io/badge/dependencies-0-green.svg)](#) [![GitHub license](https://img.shields.io/github/license/vnbrs/burocracia.cr.svg)](https://github.com/vnbrs/burocracia.cr/blob/master/LICENSE) 
> All Brazilian boring burocracias solved

burocracia.cr is the dependecyless Crystal shard to validate, generate and format Brazilian burocracias such as CPF, CNPJ and CEP.

[(clique aqui para uma versão em português 🇧🇷)](https://github.com/vnbrs/burocracia.cr/blob/master/README.pt.md)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  burocracia:
    github: vnbrs/burocracia.cr
```

## Usage

```crystal
require "burocracia"

Burocracia::CEP.generate
=> "23230133"

Burocracia::CEP.generate(format: true)
=> "71946-192"

Burocracia::CEP::Address.find "80210-130"
=> #<CEP::Address:0x10e1b83c0 @cep="80210130", @neighborhood="Jardim Botânico", @city="Curitiba", @street="Rua José Ananias Mauad", @state="Paraná", @state_abbreviation="PR">

Burocracia::CPF.valid?("10880423971")
=> false

Burocracia::CNPJ.format("92583745000149")
=> "92.583.745/0001-49"

Burocracia::CNPJ.sanitize("92.583.745/0001-49")
=> "92583745000149"
```

Read the full documentation [here](https://vnbrs.github.io/burocracia.cr/Burocracia).

## Contributing

1. Fork it ( https://github.com/vnbrs/burocracia.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

Please, don't forget to document the code and run `crystal docs` to apply the changes to `/docs` folder.

## Contributors

- [vnbrs](https://github.com/vnbrs) Vinicius Brasil - creator, maintainer
