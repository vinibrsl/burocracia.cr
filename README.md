# burocracia.cr : all Brazilian burocracias solved [![Build Status](https://travis-ci.org/vnbrs/burocracia.cr.svg?branch=master)](https://travis-ci.org/vnbrs/burocracia.cr)

burocracia.cr is the dependecyless Crystal shard to validate, generate and format Brazilian burocracias such as CPF, CNPJ and CEP.

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

Burocracia::CEP.valid? "80210130"
=> true

Burocracia::CEP.valid? "80210-130"
=> true
```

Read the full documentation [here](https://vnbrs.github.io/burocracia.cr/Burocracia).

## Contributing

1. Fork it ( https://github.com/vnbrs/burocracia.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [vnbrs](https://github.com/vnbrs) Vinicius Brasil - creator, maintainer
