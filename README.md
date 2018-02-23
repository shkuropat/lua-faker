# lua-faker
Fake identities generator (names, addresses, phones, IPs and others). Supports multiple languages.
Locales are taken from [ruby version](https://github.com/stympy/faker/tree/v1.6.6/lib/locales)
At this moment only for tarantool.

Contents
--------

- [Installing](#installing)
- [Usage](#usage)
  - [Faker.Address](#fakeraddress)
  - [Faker.App](#fakerapp)
  - [Faker.Avatar](#fakeravatar)
  - [Faker.Beer](#fakerbeer)
  - [Faker.Bitcoin](#fakerbitcoin)
  - [Faker.Book](#fakerbook)
  - [Faker.Boolean](#fakerboolean)
  - [Faker.Business](#fakerbusiness)
  - [Faker.Cat](#fakerat)
  - [Faker.ChuckNorris](#fakerchucknorris)
  - [Faker.Code](#fakercode)
  - [Faker.Color](#fakercolor)
  - [Faker.Commerce](#fakercommerce)
  - [Faker.Company](#fakercompany)
  - [Faker.Crypto](#fakercrypto)
  - [Faker.Date](#fakerdate)
  - [Faker.Educator](#fakereducator)
  - [Faker.File](#fakerfile)
  - [Faker.Finance](#fakerfinance)
  - [Faker.GameOfThrone](#fakergameofthrone)
  - [Faker.Hacker](#fakerhacker)
  - [Faker.Hipster](#fakerhipster)
  - [Faker.IDNumber](#fakeridnumber)
  - [Faker.Internet](#fakerinternet)
  - [Faker.Lorem](#fakerlorem)
  - [Faker.Music](#fakermusic)
  - [Faker.Name](#fakername)
  - [Faker.Number](#fakernumber)
  - [Faker.PhoneNumber](#fakerphonenumber)
  - [Faker.Placeholdit](#fakerplaceholdit)
  - [Faker.Pokemon](#fakerpokemon)
  - [Faker.SlackEmoji](#fakerslackemoji)
  - [Faker.Space](#fakerspace)
  - [Faker.Superhero](#fakersuperhero)
  - [Faker.Team](#fakerteam)
  - [Faker.Time](#fakertime)
  - [Faker.University](#fakeruniversity)
  - [Faker.Vehicle](#fakervehicle)
  - [Faker.Yoda](#fakervehicle)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)

## Installing
----------
```bash
tarantoolctl rocks install faker
```

## Usage

### Faker.Address


```lua
Faker.Address:city() -- "Port Devanfort"

Faker.Address:street_name() -- "Nitzsche Plain"

Faker.Address:street_suffix() -- "Parks"

Faker.Address:city_suffix() -- "chester"

Faker.Address:city_prefix() -- "South"

Faker.Address:state_abbr() -- "ME"

Faker.Address:state() -- "Nebraska"

Faker.Address:time_zone() -- "Asia/Urumqi"

Faker.Address:country() -- "Canada"

Faker.Address:country_code() -- "CM"

Faker.Address:secondary_address() -- "Suite 293"

Faker.Address:building_number() -- "293"

Faker.Address:latitude() -- "59.555329564515"

Faker.Address:longitude() -- "115.68613648658"

Faker.Address:zip_code() -- "29388-6667"

-- alias for zip_code
Faker.Address:zip() -- "29388-6667"

-- alias for zip_code
Faker.Address:postcode() -- "29388-6667"

-- Optional parameter: secondary_address=false
Faker.Address:street_address() -- "2938 Nitzsche Plain"
Faker.Address:street_address(true) -- "293 Schuster Port Suite 293"

-- en-US only
-- Optional parameter: state_abbreviation=''
Faker.Address:zip_code("AL") -- "35029"
```

### Faker.App


```lua
Faker.App:name() -- "Treeflex"

Faker.App:author() -- "Jackson Hermann"

Faker.App:version() -- "0.13"
```

### Faker.Avatar


```lua
Faker.Avatar:image() -- "https://robohash.org/etsitrem.png?size=300x300&set=set1"
Faker.Avatar:image("my-own-slug") -- "https://robohash.org/my-own-slug.png?size=300x300&set=set1"
Faker.Avatar:image("my-own-slug", "50x50") -- "https://robohash.org/my-own-slug.png?size=50x50&set=set1"
Faker.Avatar:image("my-own-slug", "50x50", "jpg") -- "https://robohash.org/my-own-slug.jpg?size=50x50&set=set1"
Faker.Avatar:image("my-own-slug", "50x50", "bmp") -- "https://robohash.org/my-own-slug.bmp?size=50x50&set=set1"
Faker.Avatar:image("my-own-slug", "50x50", "bmp", "set1", "bg1") -- "https://robohash.org/my-own-slug.bmp?size=50x50&set=set1&bgset=bg1"
```

### Faker.Beer


```lua
Faker.Beer:name() -- "Shakespeare Oatmeal"

Faker.Beer:style() -- "English Pale Ale"

Faker.Beer:hop() -- "Simcoe"

Faker.Beer:yeast() -- "2001 - Urquell Lager"

Faker.Beer:malts() -- "Chocolate malt"

Faker.Beer:malt() -- "Rye malt"

Faker.Beer:ibu() -- "75 IBU"

Faker.Beer:alcohol() -- "3.2%"

Faker.Beer:blg() -- "11.5°Blg"
```

### Faker.Bitcoin

TODO


### Faker.Book


```lua
Faker.Book:title() -- "Beneath the Bleeding"

Faker.Book:publisher() -- "Vintage Books at Random House"

Faker.Book:genre() -- "Narrative nonfiction"

Faker.Book:author() -- "Dr. Marianna Heidenreich"
```

### Faker.Boolean


```lua
-- Optional parameter: true_ratio=0.5
Faker.Boolean:boolean() -- true
Faker.Boolean:boolean(0.2) -- false
```

### Faker.Business


```lua
Faker.Business:credit_card_number() -- "1228-1221-1221-1431"

Faker.Business:credit_card_type() -- "diners_club"

Faker.Business:credit_card_expiry_date() --[[
{ 
  day = 23,
  hour = 20,
  isdst = false,
  min = 53,
  month = 2,
  sec = 18,
  wday = 6,
  yday = 54,
  year = 2018 
}
]]
```

### Faker.Cat


```lua
Faker.Cat:name() -- "Molly"

Faker.Cat:breed() -- "Korean Bobtail"

Faker.Cat:registry() -- "Fédération Internationale Féline"
```

### Faker.ChuckNorris

from: https://github.com/jenkinsci/chucknorris-plugin/blob/master/src/main/java/hudson/plugins/chucknorris/FactGenerator.java


```lua
Faker.ChuckNorris:fact() -- "Chuck Norris is immutable. If something's going to change, it's going to have to be the rest of the universe."
```

### Faker.Code

TODO

### Faker.Color


```lua
Faker.Color:color_name() -- "purple"

Faker.Color:name() -- "green"

Faker.Color:hex_color() -- "#61f7d0"

Faker.Color:single_rgb_color() -- 218

Faker.Color:rgb_color() --[[
{ 117, 188, 22 }
]]

Faker.Color:single_hsl_color() -- 231

Faker.Color:alpha_channel() -- 0.36787212124419

Faker.Color:hsl_color() --[[
{ 266.95, 300.94, 72.78 }
]]

Faker.Color:hsla_color() --[[
{ 284.83, 27.17, 354.99, 0.03013679488552 }
]]
```

### Faker.Commerce


```lua
Faker.Commerce:color() -- "indigo"

Faker.Commerce:product_name() -- "Rustic Rubber Clock"

Faker.Commerce:material() -- "Plastic"

Faker.Commerce:price() -- 44.38

-- Optional arguments max=3, fixed_amount=false
Faker.Commerce:department() -- "Automotive, Baby, Electronics & Sports"
Faker.Commerce:department(5) -- "Grocery, Games, Health, Automotive & Movies"
Faker.Commerce:department(2, true) -- "Garden & Health"
```

### Faker.Company


```lua
Faker.Company:suffix() -- "Inc"

Faker.Company:industry() -- "Fund-Raising"

Faker.Company:profession() -- "statistician"

Faker.Company:name() -- "Walker Group"

Faker.Company:catch_phrase() -- "Organized global installation"

Faker.Company:buzzword() -- "Virtual"

Faker.Company:bs() -- "orchestrate scalable functionalities"

Faker.Company:ein() -- "51-7582351"

Faker.Company:duns_number() -- "48-959-4278"

Faker.Company:swedish_organisation_number() -- "0747834117"

Faker.Company:australian_business_number() -- "93078812541"

-- Get a random company logo url in PNG format.
Faker.Company:logo() -- "https://pigment.github.io/fake-logos/logos/medium/color/6.png"
```

### Faker.Crypto


```lua
Faker.Crypto:md5() -- "3a60dc40f4e885528a49af113d11b815"

Faker.Crypto:sha1() -- "9c6f621e2c01456a2cd2c329ba8a44415446d48d"

Faker.Crypto:sha256() -- "68c20da366e8463326e368304c020bd3ef2cd8d21714307a5bce793960b8d7b4"
```

### Faker.Date

TODO



### Faker.Educator


```lua
Faker.Educator:university() -- "Marblewald Technical College"

Faker.Educator:course() -- "Associate Degree in Psychology"

Faker.Educator:secondary_school() -- "Iceborough High"

Faker.Educator:campus() -- "Brighthurst Campus"
```

### Faker.File


```lua
Faker.File:extension() -- "key"

Faker.File:mime_type() -- "image/svg+xml"

-- Optional arguments: dir, name, extension, directory_separator
Faker.File:file_name('path/to') -- "path/to/corrupti.gif"
Faker.File:file_name('foo/bar', 'baz') -- "foo/bar/baz.ods"
Faker.File:file_name('foo/bar', 'baz', 'doc') -- "foo/bar/baz.doc"
Faker.File:file_name('foo\\bar', 'baz', 'doc') -- "foo\bar\baz.doc"
Faker.File:file_name('foo/bar', 'baz', 'mp3', '\\') -- "foo\bar\baz.mp3"
```

### Faker.Finance


```lua
--Optional parameter: types={
--  'visa', 
--  'mastercard', 
--  'discover', 
--  'american_express', 
--  'diners_club', 
--  'jcb', 
--  'switch', 
--  'solo', 
--  'dankort', 
--  'maestro', 
--  'forbrugsforeningen', 
--  'laser' 
--}
Faker.Finance:credit_card() -- "4185-6891-6148-7938"
```

### Faker.GameOfThrones


```lua
Faker.GameOfThrones:characters() -- "Samwell Tarly"

Faker.GameOfThrones:houses() -- "Tyrell"

Faker.GameOfThrones:cities() -- "Samyrian"
```

### Faker.Hacker

Are you having trouble writing tech-savvy dialogue for your latest screenplay?
Worry not! Hollywood-grade technical talk is ready to fill out any form where you need to look smart.


```lua
Faker.Hacker:abbreviation() -- "AI"

Faker.Hacker:adjective() -- "1080p"

Faker.Hacker:noun() -- "system"

Faker.Hacker:verb() -- "hack"

Faker.Hacker:ingverb() -- "parsing"

Faker.Hacker:say_something_smart() -- "Use the neural XSS array, then you can parse the digital application!"
```

### Faker.Hipster


```lua
Faker.Hipster:word() -- "aliquid"

-- Optional arguments: num=3, supplemental=false, spaces_allowed = false
Faker.Hipster:words() --[[
{ 'DIY', 'neutra', 'keffiyeh' }
]]
Faker.Hipster:words(4) --[[
{ 'semiotics', 'sustainable', 'blog', 'butcher' }
]]
Faker.Hipster:words(4, true) --[[
{ 'architecto', 'eum', 'sunt', 'veritatis' }
]]
Faker.Hipster:words(4, true, true) --[[
{ 'rerum', 'rerum', 'quam', 'aliquam' }
]]

-- Optional arguments: word_count=4, supplemental=false, random_words_to_add=6
Faker.Hipster:sentence() -- "Whatever craft beer dolorem voluptas kinfolk."
Faker.Hipster:sentence(3) -- "Schlitz consequatur et illum sed."
Faker.Hipster:sentence(3, true) -- "Qui dolores quibusdam dolor."
Faker.Hipster:sentence(3, false, 4) -- "Et quo soluta ad facere quia."
Faker.Hipster:sentence(3, true, 4) -- "Selvage cupiditate vice ut."

-- Optional arguments: sentence_count=3, supplemental=false
Faker.Hipster:sentences() --[[
{ 'Non omnis et ramps laudantium est rerum quia.', 
  'Eos meditation at quia ut aspernatur nisi voluptatibus ut.', 
  'Scenester aut est est direct trade ipsa brooklyn.' }
]]
Faker.Hipster:sentences(1) --[[
{ 'Skateboard quaerat voluptatem carry id.' }
]]
Faker.Hipster:sentences(1, true) --[[
{ 'Molestias magni molestiae quam non listicle rerum.' }
]]

-- Optional arguments: sentence_count=3, supplemental=false, random_sentences_to_add=3
Faker.Hipster:paragraph() -- "Nesciunt facilis est tousled praesentium architecto illo molestiae kombucha qui. Error at dolorum pitchfork quaerat rerum dolor ratione iure. Ducimus recusandae ut eius officiis. Eos numquam dolore hic ullam. Accusamus ex quidem in polaroid sit aut voluptate sit reprehenderit. Iusto deleniti quidem eaque cred."
Faker.Hipster:paragraph(2) -- "Molestiae et austin eos etsy non reprehenderit consequatur. Qui ullam unde mumblecore accusamus dolores suscipit nihil voluptatum. Aut corporis consequatur cupiditate odio at five dollar toast facere ex. Ut ipsa soluta iusto qui suscipit provident marfa harum. Doloremque lumbersexual harum disrupt ut in laboriosam ratione kinfolk."
Faker.Hipster:paragraph(2, true) -- "Omnis consequatur provident laborum nesciunt maiores. Quo quos est non nam enim ipsa magnam. Shoreditch minus assumenda at necessitatibus quae eius nisi eos rem. Eaque cumque velit itaque roof autem minus."
Faker.Hipster:paragraph(2, false, 4) -- "Qui carry voluptatem assumenda necessitatibus expedita. Church-key est inventore assumenda ut excepturi vitae. Est ab dolores et sed repudiandae possimus consequatur Thundercats. Ad aut molestiae aliquid incidunt dolor culpa."
Faker.Hipster:paragraph(2, true, 4) -- "Odit sit consectetur harum listicle molestiae recusandae consequatur. In pariatur aut chartreuse vel aut quo nostrum. Sunt dolorem minima tumblr doloribus."

-- Optional arguments: paragraph_count=3, supplemental=false
Faker.Hipster:paragraphs() --[[
{ 
  [[Dicta itaque cupiditate dolor sint quia in chillwave. Ex street ut eum earum. 
  Voluptas adipisci enim accusantium et sit rerum inventore doloremque. Vero ut as
  sumenda modi ducimus est minima. Id in hic excepturi asperiores impedit tempore 
  dicta id qui.]], 
  [[Et numquam offal perspiciatis modi voluptate non totam ut. Iure pariatur quis 
  ut et ea. Sit est nihil voluptatum sunt accusantium. Similique sed expedita tild
  e quia omnis laborum tilde.]], 
  [[Et sit iusto dolore numquam sequi magni natus eum est. Eos harum ut fugit nihi
  l animi. Sint facilis maxime quia corrupti reiciendis laborum quia in. Dolore re
  m kale chips facilis molestiae eos. Iure kinfolk expedita dolore aut dolorem qui
   aut. Next level est vel officia ea voluptatem quia.]] }
]]
Faker.Hipster:paragraphs(1) --[[
{ 
  [[Listicle in soluta beatae dolorum excepturi qui. Et nihil autem accusantium in
   eaque et. Ut magnam fuga qui odio aspernatur esse cupiditate velit doloremque. 
  Consequatur et ut quis dicta dolore occaecati. Voluptatem minima commodi ratione
   quasi quas culpa expedita semiotics butcher. Nemo perspiciatis porro labore nis
  i ipsam molestiae dolores et reprehenderit.]] }
]]
Faker.Hipster:paragraphs(1, true) --[[
{ 
  [[Rerum est ipsum temporibus voluptate narwhal est iste reiciendis est. Id nesci
  unt voluptatem dignissimos mollitia sunt facilis est dicta. Temporibus enim vita
  e doloribus mollitia perspiciatis excepturi dolore craft beer repudiandae. Asper
  iores numquam aliquid alias aut possimus repellat. Eos et dolore et asperiores q
  ui. Voluptatem odit vel esse tenetur quis.]] }
]]
```

### Faker.IDNumber


```lua
Faker.IDNumber:valid() -- "382-19-7769"

Faker.IDNumber:invalid() -- "666-54-4932"

Faker.IDNumber:ssn_valid() -- "382-19-7769"
```

### Faker.Internet


```lua
Faker.Internet:domain_suffix() -- "org"

Faker.Internet:domain_name() -- "becker-mueller.io"

Faker.Internet:domain_word() -- "Harber,"

Faker.Internet:ip_v4_address() -- "127.55.47.98"

Faker.Internet:ip_v4_cidr() -- "181.207.121.239/23"

Faker.Internet:ip_v6_address() -- "4012:1c55:d2ea:2590:bcc7:e8e1:249f:f0cd"

Faker.Internet:ip_v6_cidr() -- "423:5941:c756:c1dc:3565:83a2:c180:d9f5/65"

Faker.Internet:device_token() -- "d7865023667db4940280e70dfd9d969112ff806e5e1779e19bdbba85cd1e3514"

-- Optional argument name=nil
Faker.Internet:email() -- "eino.crona@haley.com"
Faker.Internet:email('Nancy') -- "nancy@cummings,.name"

-- Optional argument name=nil
Faker.Internet:free_email() -- "lauretta@gmail.com"
Faker.Internet:free_email('Nancy') -- "nancy@yahoo.com"

-- Optional argument name=nil
Faker.Internet:safe_email() -- "milford_barton@example.org"
Faker.Internet:safe_email('Nancy') -- "nancy@example.com"

-- Optional arguments specifier=nil, separators={'.', '_'}
Faker.Internet:user_name() -- "ottis"
Faker.Internet:user_name('Nancy') -- "nancy"
Faker.Internet:user_name('Nancy Johnson', {'.', '_', '-'}) -- "johnson_nancy"

-- Optional arguments: min_length=8, max_length=16
Faker.Internet:password() -- "8RmVx2eMrHzF"
Faker.Internet:password(8) -- "yH0AdC4PdJf"
Faker.Internet:password(10, 20) -- "aKm6v65R8X2F2"
Faker.Internet:password(10, 20, true) -- "28j6q6oBxE8"

-- Private IP range according to RFC 1918 and 127.0.0.0/8 and 169.254.0.0/16.
Faker.Internet:private_ip_v4_address() -- "172.31.31.97"

-- Guaranteed not to be in the ip range from the private_ip_v4_address method.
Faker.Internet:public_ip_v4_address() -- "150.145.185.136"

-- Optional argument prefix=''
Faker.Internet:mac_address() -- "93:8c:81:02:fd:77"
Faker.Internet:mac_address('55:44:33') -- "55:44:33:5f:e9:a7"

-- Optional arguments: host=domain_name, path="/#{user_name}"
Faker.Internet:url() -- "http://keebler.io/cara_schowalter"
Faker.Internet:url('example.com') -- "http://example.com/destiny"
Faker.Internet:url('example.com', '/foobar.html') -- "http://example.com/foobar.html"

-- Optional arguments: words=nil, glue=nil
Faker.Internet:slug() -- "iste_quo"
Faker.Internet:slug('foo bar') -- "foo.bar"
Faker.Internet:slug('foo bar', '-') -- "foo-bar"
```

### Faker.Lorem


```lua
Faker.Lorem:word() -- "eligendi"

Faker.Lorem:question() -- "Maxime omnis dolor sunt itaque hic aut?"

Faker.Lorem:questions() --[[
{ 'Vitae qui dolorem nostrum perferendis dicta?', 
  'Corporis libero minus ut eum qui ducimus?', 
  'Itaque et beatae repellendus praesentium?' }
]]

-- Optional arguments: num=3, supplemental=false (words from a supplementary list of Lorem-like words)
Faker.Lorem:words() --[[
{ 'et', 'corporis', 'ea' }
]]
Faker.Lorem:words(4) --[[
{ 'accusantium', 'modi', 'voluptatibus', 'eos' }
]]
Faker.Lorem:words(4, true) --[[
{ 'vinco', 'ambulo', 'cognatus', 'cui' }
]]

-- Optional arguments: char_count=255
Faker.Lorem:characters() -- "oc6ttcpxr5ab7fzzu9jeqc4vcmczoao9ali520e8llszw96iftovdf9orie6iga35azikfcf53xgh0bxrlt5yfog3oyrmdrpmr71eeu1xj62smv6uivw6o1c0a2tj9u9hndht4vds0z1rvp9tuxtu4qd3rd58b8z4z2te4iy1gyjeu3ld5d8qr4lxj0b2v8bhdq089d81djt1am66dfqcbxm7p0kstx8xqgu354qzq9pn335of9alkrp331x60o"
Faker.Lorem:characters(10) -- "00kxcjjznf"

-- Optional arguments: word_count=4, supplemental=false, random_words_to_add=6
Faker.Lorem:sentence() -- "Uredo volaticus suadeo vitiosus studio ducimus terminatio cuius vulariter quo."
Faker.Lorem:sentence(3) -- "Vulticulus adduco vitium quisquam et absorbeo."
Faker.Lorem:sentence(3, true) -- "Verecundia vetus adopto acies ipsa velut stultus spargo."
Faker.Lorem:sentence(3, false, 4) -- "Torqueo vado id thema sperno casus congregatio."
Faker.Lorem:sentence(3, true, 4) -- "Vorago verumtamen cunctatio crinis demo depulso aveho."

-- Optional arguments: sentence_count=3, supplemental=false
Faker.Lorem:sentences() --[[
{ 'Alienus vereor acervus creptio sordeo terra.', 
  'Subseco acsi admiratio aduro vapulus basium ventosus comprehendo patruus.', 
  'Triumphus vomito super apud somniculosus adicio.' }
]]
Faker.Lorem:sentences(1) --[[
{ 'Amicitia cometes asporto admiratio corrigo aer venia vinitor admoveo.' }
]]
Faker.Lorem:sentences(1, true) --[[
{ 'Una acidus tui pel trepide aliquid cribro.' }
]]

-- Optional arguments: sentence_count=3, supplemental=false, random_sentences_to_add=3
Faker.Lorem:paragraph() -- "Demoror pecco tantillus denuncio cribro caute tantillus bibo vindico. Adimpleo comburo territo vilicus una sortitus cura. Clibanus vel vae attollo varius admiratio peior absque civitas. Via pecto quia acceptus suus tertius. Defungo creptio abundans amplexus cometes venia speciosus bonus cogito. Curtus credo viscus adfectus terreo autem."
Faker.Lorem:paragraph(2) -- "Ciminatio aequus patrocinor crebro aut. Coaegresco clarus aperio deputo porro virga inflammatio. Suasoria ceno ocer delinquo sto coepi colo tui videlicet. Accedo victus stabilis benigne ara degero copiose. Adicio vergo spes vestrum civis concedo usque crustulum."
Faker.Lorem:paragraph(2, true) -- "Vilitas tantum amplitudo demo virtus deprimo synagoga tametsi amaritudo. Sollers tam tendo demum adflicto sto. Sumptus accusator advenio coaegresco vacuus cupio virgo tergeo suadeo. Statua degenero usitas desino calamitas. Agnitio creta denuo cursus trans."
Faker.Lorem:paragraph(2, false, 4) -- "Ciminatio cresco tergeo theca aliquam demum templum curatio voveo. Theologus timor aggredior teres cruentus theologus. Chirographum vitae ullus concedo coepi capto cum."
Faker.Lorem:paragraph(2, true, 4) -- "Capillus viduata sopor vigilo absum. Absens vorax demonstro tubineus tibi autem crapula comptus. Comptus canto cotidie subvenio vigilo. Vesper ambitus decor suppellex vinitor cunae. Adversus ocer verbum tendo tricesimus conservo. Aperio totus vero vero votum condico capio cras debilito desolo."

-- Optional arguments: paragraph_count=3, supplemental=false
Faker.Lorem:paragraphs() --[[
{ 
  [[Crudelis vigilo patrocinor pel creta circumvenio vulnero teres. Coniuratio ter
  gum caterva capto depromo dens adsidue colligo. Vindico sumo demulceo aufero def
  luo cimentarius angustus. Suppono beneficium correptius speculum delego.]], 
  [[Color crepusculum solus velut taedium turbo triginta ars textilis valde. Coma 
  conventus terminatio circumvenio tabula thymbra vere summisse. Vestrum vultuosus
   turbo spectaculum acer vestrum adultus vero. Adicio ciminatio amiculum cognomen
   cernuus strenuus conicio abeo autus.]], 
  [[Curia capto armo avaritia vulariter templum. Arcesso cum aegrus textilis antiq
  uus. Comburo speciosus confugo volubilis abundans volubilis amplexus canonicus s
  olutio bos. Verbum conatus tam cubicularis tolero. Summopere dedecor canis vaco 
  spiculum adnuo caste validus ustulo vergo.]] }
]]
Faker.Lorem:paragraphs(1) --[[
{ 
  [[Delicate paens vulgivagus subvenio vado desipio sum comburo cubitum. Cognomen 
  stultus ager assentator turba ascit tui tantum ancilla asporto. Subseco desipio 
  armarium vivo cunae inflammatio approbo adiuvo cattus curto. Somniculosus subiun
  go sub curvo damno theatrum super audio vado. Tergeo aiunt depraedor vero tredec
  im. Corona toties suscipio vestrum tubineus aiunt.]] }
]]
Faker.Lorem:paragraphs(1, true) --[[
{ 
  [[Avoco crastinus acsi adaugeo ullus cervus vicissitudo denuncio amissio. Textil
  is texo venio desidero utroque amissio catena accendo. Deprimo tristis celo vall
  um colloco. Umbra speciosus aranea pauci delinquo avoco arma. Chirographum tumul
  tus voro ait torqueo tero. Copia summa summisse tubineus audax sumo coruscus adi
  mpleo teneo vulariter.]] }
]]
```

### Faker.Music


```lua
Faker.Music:instrument() -- "Drums"

Faker.Music:instruments() -- "Ukelele"

Faker.Music:keys() --[[
{ 'C', 'D', 'E', 'F', 'G', 'A', 'B' }
]]

Faker.Music:key_variants() --[[
{ 'b', '#', '' }
]]
```

### Faker.Name


```lua
Faker.Name:name() -- "Dylan Crist"

Faker.Name:name_with_middle() -- "Edna Hollie Skiles"

Faker.Name:last_name() -- "Satterfield"

Faker.Name:first_name() -- "Savion"

Faker.Name:prefix() -- "Ms."

Faker.Name:suffix() -- "II"

Faker.Name:title() -- "National Accountability Orchestrator"
```

### Faker.Number


```lua
Faker.Number:positive() -- 4836.8253135714

Faker.Number:negative() -- -523.22792520235

Faker.Number:digit() -- "7"

-- Required parameter: digits
Faker.Number:number(10) -- "8458486667"

-- Required parameter: l_digits
Faker.Number:decimal(2) -- "80.46"
Faker.Number:decimal(2, 3) -- "95.352"

-- Required parameter: digits
Faker.Number:hexadecimal(3) -- "202"

Faker.Number:between(1, 10) -- 2
```

### Faker.PhoneNumber

Phone numbers may be in any of the following formats:

  * 333-333-3333
  * (333) 333-3333
  * 1-333-333-3333
  * 333.333.3333
  * 333-333-3333
  * 333-333-3333 x3333
  * (333) 333-3333 x3333
  * 1-333-333-3333 x3333
  * 333.333.3333 x3333

(Don't let the example output below fool you - any format can be returned at random.)


```lua
-- Optional parameter: length=4
Faker.PhoneNumber:subscriber_number() -- "127"
Faker.PhoneNumber:subscriber_number(2) -- "94"

Faker.PhoneNumber:extension() -- "398"

-- en-US only
Faker.PhoneNumber:area_code() -- "641"

Faker.PhoneNumber:exchange_code() -- "320"
```

### Faker.Placeholdit


```lua
Faker.Placeholdit:image() -- "https://placehold.it/300x300.png"
Faker.Placeholdit:image("50x50") -- "https://placehold.it/50x50.png"
Faker.Placeholdit:image("50x50", 'jpg') -- "https://placehold.it/50x50.jpg"
Faker.Placeholdit:image("50x50", 'gif', 'ffffff') -- "https://placehold.it/50x50.gif/ffffff"
Faker.Placeholdit:image("50x50", 'jpeg', 'ffffff', '000') -- "https://placehold.it/50x50.jpeg/ffffff/000"
Faker.Placeholdit:image("50x50", 'jpg', 'ffffff', '000', 'Some Custom Text') -- "https://placehold.it/50x50.jpg/ffffff/000?text=Some Custom Text"
```

### Faker.Pokemon


```lua
Faker.Pokemon:name() -- "Articuno"

Faker.Pokemon:location() -- "Coumarine City"
```

### Faker.SlackEmoji


```lua
Faker.SlackEmoji:people() -- ":sweat:"

Faker.SlackEmoji:nature() -- ":cat2:"

Faker.SlackEmoji:food_and_drink() -- ":melon:"

Faker.SlackEmoji:celebration() -- ":tanabata_tree:"

Faker.SlackEmoji:activity() -- ":trumpet:"

Faker.SlackEmoji:travel_and_places() -- ":minibus:"

Faker.SlackEmoji:objects_and_symbols() -- ":chart:"

Faker.SlackEmoji:custom() -- ":dusty_stick:"

-- Random Slack Emoji from any category
Faker.SlackEmoji:emoji() -- ":octocat:"
```

### Faker.Space

```lua
Faker.Space:planet() -- "Neptune"

Faker.Space:moon() -- "Ganymede"

Faker.Space:galaxy() -- "Andromeda"

Faker.Space:nebula() -- "Lagoon Nebula"

Faker.Space:star_cluster() -- "NGC 2808"

Faker.Space:constellation() -- "Ursa Major"

Faker.Space:star() -- "Procyon A"

Faker.Space:agency() -- "European Space Agency"

Faker.Space:agency_abv() -- "ROSCOSMOS"

Faker.Space:nasa_space_craft() -- "Orion"

Faker.Space:company() -- "SpaceDev"

Faker.Space:distance_measurement() -- "49 light years"
```

### Faker.Superhero


```lua
Faker.Superhero:power() -- "Cross-Dimensional Travel"

Faker.Superhero:prefix() -- "Dark"

Faker.Superhero:suffix() -- "Machine"

Faker.Superhero:descriptor() -- "Aqualad"

Faker.Superhero:name() -- "Starfire"
```

### Faker.Team


```lua
Faker.Team:creature() -- "black cats"

Faker.Team:name() -- "Nebraska goblins"

Faker.Team:state() -- "Connecticut"
```

### Faker.Time

TODO



### Faker.University


```lua
Faker.University:prefix() -- "Western"

Faker.University:suffix() -- "Institute"

Faker.University:name() -- "Roob College"
```

### Faker.Vehicle


```lua
Faker.Vehicle:vin() -- "1A92LYN80FGYFUGKW"

Faker.Vehicle:manufacture() -- "AMERICAN TRANSPORTATION CORPORATION"
```

### Faker.Yoda


```lua
Faker.Yoda:quote() -- "Always pass on what you have learned."
```

## Customization

TODO

## Contributing

TODO

## License
-------
This code is free to use under the terms of the MIT license.

