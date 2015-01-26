musemeta
=======



[![Build Status](https://api.travis-ci.org/ropensci/musemeta.png)](https://travis-ci.org/ropensci/musemeta)
[![Build status](https://ci.appveyor.com/api/projects/status/y3tefs9xb6pmql36/branch/master?svg=true)](https://ci.appveyor.com/project/sckott/musemeta/branch/master)

**R client for museum metadata**

Currently `musemeta` can get data from:

* [The Metropolitan Museum of Art](http://www.metmuseum.org/) via 
    * scraping the MET website (see function `met()`)
    * http://scrapi.org/ (see functions `scrapi_()`) - __UPDATE__: THIS API IS TEMPORARILY DOWN, THESE FUNCTIONS NOW SPIT OUT A MESSAGE SAYING SO...
* The [Canadian Science & Technology Museum Corporation](http://techno-science.ca/en/index.php) (CSTMC) (see functions `cstmc_()`)
* The [National Gallery of Art](http://www.nga.gov/content/ngaweb.html) (NGA) (see function `nga()`)
* The [Getty Museum](http://www.getty.edu/) (see function `getty()`)
* The [Art Institute of Chicago](http://www.artic.edu/) (see function `aic()`)
* The [Asian Art Museum of San Francisco](http://www.asianart.org/) (see function `aam()`)

Other sources of museum metadata will be added...check back later & see [issues](https://github.com/ropensci/musemeta/issues).

## Install

Get `ckanr` first, not on CRAN yet (I'll get `ckanr` up to CRAN before this is on CRAN)


```r
devtools::install_github("ropensci/ckanr")
```

Then install musemeta


```r
devtools::install_github("ropensci/musemeta")
```


```r
library("musemeta")
```

## MET data

To get actual metadata for an object, you can use `met()` or `scrapi_get()` functions. The latter gets much more data, and uses a REST API, while the former scrapes the html directly, and can be more fragile with any changes in the html on the site.

### Scraping site directly

Data for a single object


```r
met(559490)
#> Error in xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]: subscript out of bounds
```

Or index to name of object, or values in the description


```r
met(559490)$name
#> Error in xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]: subscript out of bounds
```


```r
met(559490)$values[1:2]
#> Error in xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]: subscript out of bounds
```

A different object


```r
met(246562)
#> Error in xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]: subscript out of bounds
```

Get many objects


```r
lapply(c(479283, 228901, 436876), met)
#> Error in xpathApply(tmp, "//div[@class='tombstone-container']")[[1]]: subscript out of bounds
```

### Using the scrapi API

SCRAPI FUNCTIONS ARE DOWN TEMPORARILY

This is again, for The Metropolitan Museum of Art only 

Get a random object, limit to a few fields for brevity


```r
scrapi_random(fields=c('medium','whoList'))
```

Get a specific object


```r
scrapi_info(123, fields=c('title','primaryArtistNameOnly','medium'))
```

Search for objects


```r
scrapi_search(query='mirror')
```

Get an object, with a scrapi.org url


```r
out <- scrapi_get("http://scrapi.org/object/427581")
out$primaryArtist
```

or an object id


```r
out <- scrapi_get(427581)
out$primaryArtist
```

## CSTMC data

List changes


```r
cstmc_changes(limit = 1)
#> [[1]]
#> [[1]]$user_id
#> [1] "27778230-2e90-4818-9f00-bbf778c8fa09"
#> 
#> [[1]]$timestamp
#> [1] "2015-01-09T23:33:14.303237"
#> 
#> [[1]]$object_id
#> [1] "0a801729-aa94-4d76-a5e0-7b487303f4e5"
#> 
#> [[1]]$revision_id
#> [1] "100c4915-f995-4925-956e-bcacfdd8de89"
#> 
#> [[1]]$data
#> [[1]]$data$package
#> [[1]]$data$package$maintainer
#> [1] ""
#> 
#> [[1]]$data$package$name
#> [1] "scientific-instrumentation-astronomy-astronomie"
#> 
#> [[1]]$data$package$metadata_modified
#> [1] "2015-01-09T23:33:13.972898"
#> 
#> [[1]]$data$package$author
#> [1] ""
#> 
#> [[1]]$data$package$url
#> [1] ""
#> 
#> [[1]]$data$package$notes
#> [1] "This dataset includes artifacts in the collection of the Canada Science and Technology Museums Corporation related to astronomy."
#> 
#> [[1]]$data$package$owner_org
#> [1] "fafa260d-e2bf-46cd-9c35-34c1dfa46c57"
#> 
#> [[1]]$data$package$private
#> [1] FALSE
#> 
#> [[1]]$data$package$maintainer_email
#> [1] ""
#> 
#> [[1]]$data$package$author_email
#> [1] ""
#> 
#> [[1]]$data$package$state
#> [1] "active"
#> 
#> [[1]]$data$package$version
#> [1] ""
#> 
#> [[1]]$data$package$creator_user_id
#> [1] "27778230-2e90-4818-9f00-bbf778c8fa09"
#> 
#> [[1]]$data$package$id
#> [1] "0a801729-aa94-4d76-a5e0-7b487303f4e5"
#> 
#> [[1]]$data$package$title
#> [1] "Artifact Data - Astronomy"
#> 
#> [[1]]$data$package$revision_id
#> [1] "6a0dcffe-e104-4942-93ab-a23f2a2ffe3a"
#> 
#> [[1]]$data$package$type
#> [1] "dataset"
#> 
#> [[1]]$data$package$license_id
#> [1] "ca-ogl-lgo"
#> 
#> 
#> 
#> [[1]]$id
#> [1] "b78fb52c-6447-4ded-8933-a75183d012e7"
#> 
#> [[1]]$activity_type
#> [1] "changed package"
```

List datasets


```r
cstmc_datasets(as = "table")
#> Error: 'datasets' is not an exported object from 'namespace:ckanr'
```

Search for packages


```r
out <- cstmc_package_search(q = '*:*', rows = 2, as='table')
lapply(out$results$resources, function(x) x[,1:3])
#> [[1]]
#>                      resource_group_id cache_last_updated
#> 1 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 2 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 3 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#> 4 9d1467e6-4e87-4ebf-bd73-35326fd46491                 NA
#>           revision_timestamp
#> 1 2015-01-09T23:33:13.972143
#> 2 2014-10-31T22:37:58.762911
#> 3 2014-11-05T18:23:00.789562
#> 4 2014-11-05T18:25:16.764967
#> 
#> [[2]]
#>                      resource_group_id cache_last_updated
#> 1 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 2 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 3 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#> 4 cce39b19-e07c-4c51-941b-242afd3f1c4a                 NA
#>           revision_timestamp
#> 1 2014-10-28T20:14:43.878106
#> 2 2014-11-04T03:04:24.281137
#> 3 2014-11-05T21:46:30.031396
#> 4 2014-11-05T21:48:27.302007
```

## National Gallery of Art (NGA)

Get metadata for a single object


```r
nga(id=33267)
#> <NGA metadata> Paradise with Christ in the Lap of Abraham
#>   Artist: German 13th Century
#>   Inscription: on verso late thirteenth-century copy of a letter from Pope Gregory
#>           IX to Elizabeth of Thuringia
#>   Provenance: R. Forrer (Lugt Supp.941a)
#>   Description:
#>      created: c. 1239
#>      medium: tempera and gold leaf on vellum, NGA Miniatures 1975, no. 33
#>      dimensions: overall: 22.4 x 15.7 cm (8 13/16 x 6 3/16 in.)
#>      credit: Rosenwald Collection
#>      accession: 1946.21.11
#>   Exhibition history:
#>      2007: Fabulous Journeys and Faraway Places: Travels on Paper, 1450 - 1700,
#>           National Gallery of Art, Washington, D.C., 2007
#>      2009: Heaven on Earth: Manuscript Illuminations from the National Gallery
#>           of Art, NGA, 2009.
#>   Bibliography:
#>      1975: National Gallery of Art. Medieval and Renaissance Miniatures from the
#>           National Gallery of Art. Washington, 1975.
#>      1982: Fine 1982, 45.
#>      1984: Walker, John. National Gallery of Art, Washington. Rev. ed. New York,
#>           1984: 658, no. 1033, color repro.
#>      1990: Clayton, Virginia Tuttle. Gardens on Paper: Prints and Drawings,
#>           1200-1900. Exh. cat. National Gallery of Art, Washington,
#>           1990: 1.
```

Get metadata for many objects


```r
lapply(c(143679,27773,28487), nga)
#> [[1]]
#> <NGA metadata>  Barrington bore it all with exemplary patience 
#>   Artist: Du Maurier, George
#>   Inscription: by artist, lower right in pen and brown ink: Barrington bore it all
#>           with exemplary patience / P.7 Par VI / Mlle de Mersac /
#>           [Not deciphered]; by later hand, upper right on flap in
#>           graphite: [Not deciphered] (cut off) / Reduce [to?] 6 1/4;
#>           by later hand, lower center verso in pen and blue ink: [Not
#>           deciphered] (effaced)
#>   Provenance: (Fry Gallery, London); Joseph F. McCrindle [1923-2008], New York,
#>           1968; Joseph F. McCrindle Foundation, 2008; gift to NGA,
#>           2009.
#>   Description:
#>      created: 1878/1879
#>      medium: pen and brown ink with graphite on heavy wove paper
#>      dimensions: , sheet: 22 x 30.2 cm (8 11/16 x 11 7/8 in.)
#> image (6.4 cm of sheet width is folded under): 22 x 23.8 cm (8 11/16 x 9 3/8 in.)
#>      credit: Joseph F. McCrindle Collection
#>      accession: 2009.70.110
#>   Exhibition history:
#>   Bibliography:
#>      2012: Grasselli, Margaret M., and Arthur K. Wheelock, Jr., eds. The
#>           McCrindle Gift: A Distinguished Collection of Drawings and
#>           Watercolors. Exh. cat. National Gallery of Art. Washington,
#>           2012: 169 (color).
#> 
#> [[2]]
#> <NGA metadata>  Bell Hop  Marionette
#>   Artist: Cero, Emile
#>   Inscription: lower right in black ink: EMILE CERO
#>   Provenance: NA
#>   Description:
#>      created: c. 1938
#>      medium: watercolor, graphite, and pen and ink on paper
#>      dimensions: overall: 35.5 x 28 cm (14 x 11 in.)
#> Original IAD Object: 42" high
#>      credit: Index of American Design
#>      accession: 1943.8.15682
#>   Exhibition history:
#>   Bibliography:
#> 
#> [[3]]
#> <NGA metadata>  Bell in Hand  Tavern Sign
#>   Artist: American 20th Century
#>   Inscription: 
#>   Provenance: NA
#>   Description:
#>      created: 1935/1942
#>      medium: watercolor and graphite on paper
#>      dimensions: overall: 37.7 x 26.5 cm (14 13/16 x 10 7/16 in.)
#>      credit: Index of American Design
#>      accession: 1943.8.16396
#>   Exhibition history:
#>   Bibliography:
#>      1950: Christensen, Erwin O., The Index of American Design, New York: 1950,
#>           p. 67, no. 127.
#>      1970: Hornung, Clarence P., Treasury of American Design. New York, 1970:
#>           83, pl. 265.
```

There is no search functionality yet for this source.

## Getty Museum

Get metadata for a single object


```r
getty(id=140725)
#> <Getty metadata> A Young Herdsman Leaning on his "Houlette"
#>   Artist: Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>   Provenance
#>      : Gustav Nebehay [Vienna, Austria]
#>      - 1941: Franz W. Koenigs [Haarlem, Netherlands], by inheritance to his heirs.
#>      - 2001: Private Collection (sold, Sotheby's New York, January 23, 2001, lot 20, to Bob Haboldt.)
#>      2001: Bob P. Haboldt, sold to the J. Paul Getty Museum, 2001.
#>   Description:
#>      Artist/Maker(s): Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>      Date: about 1650
#>      Medium: Black chalk and brown wash
#>      Dimensions: 27.5 x 18.6 cm (10 13/16 x 7 5/16 in.)
#>      Object Number: 2001.40
#>      Department: Drawings
#>      Culture: Dutch
#>      Previous number: L.2001.12
#>      Classification/Object Type: Drawings / Drawing
#>   Exhibition history:
#>      Dutch Drawings of the Golden Age (May 28 to August 25, 2002): The J. Paul Getty Museum at the Getty Center (Los Angeles), May 28,
#>           2002 - August 25, 2002
#>      Visions of Grandeur: Drawing in the Baroque Age (June 1 to September 12, 2004): The J. Paul Getty Museum at the Getty Center (Los Angeles), June 1,
#>           2004 - September 12, 2004
#>      Paper Art: Finished Drawings in Holland 1590-1800 (September 6 to November 20, 2005): The J. Paul Getty Museum at the Getty Center (Los Angeles), September
#>           6, 2005 - November 20, 2005
#>      Drawing Life: The Dutch Visual Tradition (November 24, 2009 to February 28, 2010): The J. Paul Getty Museum at the Getty Center (Los Angeles), November
#>           24, 2009 - February 28, 2010
```

Get metadata for many objects


```r
lapply(c(140725,8197), getty)
#> [[1]]
#> <Getty metadata> A Young Herdsman Leaning on his "Houlette"
#>   Artist: Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>   Provenance
#>      : Gustav Nebehay [Vienna, Austria]
#>      - 1941: Franz W. Koenigs [Haarlem, Netherlands], by inheritance to his heirs.
#>      - 2001: Private Collection (sold, Sotheby's New York, January 23, 2001, lot 20, to Bob Haboldt.)
#>      2001: Bob P. Haboldt, sold to the J. Paul Getty Museum, 2001.
#>   Description:
#>      Artist/Maker(s): Herman Saftleven the Younger [Dutch, 1609 - 1685]
#>      Date: about 1650
#>      Medium: Black chalk and brown wash
#>      Dimensions: 27.5 x 18.6 cm (10 13/16 x 7 5/16 in.)
#>      Object Number: 2001.40
#>      Department: Drawings
#>      Culture: Dutch
#>      Previous number: L.2001.12
#>      Classification/Object Type: Drawings / Drawing
#>   Exhibition history:
#>      Dutch Drawings of the Golden Age (May 28 to August 25, 2002): The J. Paul Getty Museum at the Getty Center (Los Angeles), May 28,
#>           2002 - August 25, 2002
#>      Visions of Grandeur: Drawing in the Baroque Age (June 1 to September 12, 2004): The J. Paul Getty Museum at the Getty Center (Los Angeles), June 1,
#>           2004 - September 12, 2004
#>      Paper Art: Finished Drawings in Holland 1590-1800 (September 6 to November 20, 2005): The J. Paul Getty Museum at the Getty Center (Los Angeles), September
#>           6, 2005 - November 20, 2005
#>      Drawing Life: The Dutch Visual Tradition (November 24, 2009 to February 28, 2010): The J. Paul Getty Museum at the Getty Center (Los Angeles), November
#>           24, 2009 - February 28, 2010
#> 
#> [[2]]
#> <Getty metadata> Grave Stele of a Boy
#>   Artist: Unknown
#>   Provenance
#>      - 1973: Nicolas Koutoulakis [Geneva, Switzerland], sold to the J. Paul Getty Museum, 1973.
#>   Description:
#>      Artist/Maker(s): Unknown
#>      Date: 1 - 50
#>      Medium: Marble
#>      Dimensions: Object: H: 87 x W: 39.1 x D: 7 cm (34 1/4 x 15 3/8 x 2 3/4 in.)
#>      Object Number: 73.AA.114
#>      Department: Antiquities
#>      Display Title: Gravestone of a Boy
#>      Culture: Roman
#>      Place Created: Roman Empire
#>      Classification/Object Type: Sculpture / Relief
#>   Exhibition history:
```

There is no search functionality yet for this source.

## Art Institute of Chicago

Get metadata for a single object


```r
aic(41033)
#> <AIC metadata> 41033
#>    Artist:
#>       Name: Charles Edmund Brock English
#>       Years: 1870-1938
#>    Link: http://www.artic.edu/aic/collections/artwork/41033
#>    Title: "'The unwelcome hints of Mr. Shepherd, his Agent,' Chapter I"
#>       frontispiece for Jane Austen's Persuasion, 1898
#>    Description: Pen and black ink with brush and watercolor, on ivory wove card 298 x
#>       222 mm Signed lower right, in pen and black ink: "C.E.Brock .
#>       1898"; inscribed, lower center: "'The unwelcome hints of Mr.
#>       Shepherd, his agent' / Chapter I"; further ink and graphite
#>       inscriptions in marginsGift of James Deering, 1927.1623
#>    Description-2: Prints and Drawings Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>      - : Jane Austen, edited by Gerald Brimley Johnson, Persuasion, in Jane
#>           Austen's Novels, Volume X, (London: Dent, 1898), p. 8
#>           (ill).
#>    Ownership history:
```

Get metadata for many objects


```r
lapply(c(41033,210804), aic)
#> [[1]]
#> <AIC metadata> 41033
#>    Artist:
#>       Name: Charles Edmund Brock English
#>       Years: 1870-1938
#>    Link: http://www.artic.edu/aic/collections/artwork/41033
#>    Title: "'The unwelcome hints of Mr. Shepherd, his Agent,' Chapter I"
#>       frontispiece for Jane Austen's Persuasion, 1898
#>    Description: Pen and black ink with brush and watercolor, on ivory wove card 298 x
#>       222 mm Signed lower right, in pen and black ink: "C.E.Brock .
#>       1898"; inscribed, lower center: "'The unwelcome hints of Mr.
#>       Shepherd, his agent' / Chapter I"; further ink and graphite
#>       inscriptions in marginsGift of James Deering, 1927.1623
#>    Description-2: Prints and Drawings Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>      - : Jane Austen, edited by Gerald Brimley Johnson, Persuasion, in Jane
#>           Austen's Novels, Volume X, (London: Dent, 1898), p. 8
#>           (ill).
#>    Ownership history: 
#> 
#> [[2]]
#> <AIC metadata> 210804
#>    Artist:
#>       Name: William H. Bell , American
#>       Years: 1830–1910
#>    Link: http://www.artic.edu/aic/collections/artwork/210804
#>    Title: The "Vermillion Cliff," a typical plateau edge, as seen from Jacobs
#>       Pool, Arizona. From its top a plateau stretches to the right,
#>       and from its base another to the left. Their difference of
#>       level is 1.500 feet, and the step is too steep for scaling.,
#>       1872
#>    Description: Albumen print, stereo, No. 15 from the series "Geographical
#>       Explorations and Surveys West of the 100th Meridian" 9.3 x 7.5
#>       cm (each image); 10 x 17.7 cm (card)Photography Gallery Fund,
#>       1959.616.13
#>    Description-2: Photography Not on Display
#>    Artwork body: 
#>    Exhibition history:
#>    Publication history:
#>    Ownership history:
```

There is no search functionality yet for this source.

## Asian Art Museum of San Francisco

Get metadata for a single object


```r
aam(11462)
#> <AAM metadata> Molded plaque (tsha tsha)
#>   Object id: 1992.96
#>   Object name: Votive plaque
#>   Date: approx. 1992
#>   Artist: 
#>   Medium: Plaster mixed with resin and pigment
#>   Credit line: Gift of Robert Tevis
#>   On display?: no
#>   Collection: Decorative Arts
#>   Department: Himalayan Art
#>   Dimensions: 
#>   Label: Molded plaques (tsha tshas) are small sacred images, flat or
#>           three-dimensional, shaped out of clay in metal molds. The
#>           images are usually unbaked, and sometimes seeds, paper, or
#>           human ashes were mixed with the clay. Making tsha tshas is
#>           a meritorious act, and monasteries give them away to
#>           pilgrims. Some Tibetans carry tsha tshas inside the amulet
#>           boxes they wear or stuff them into larger images as part of
#>           the consecration of those images. In Bhutan tsha tshas are
#>           found in mani walls (a wall of stones carved with prayers)
#>           or piled up in caves.The practice of making such plaques
#>           began in India, and from there it spread to other countries
#>           in Asia with the introduction of Buddhism. Authentic tsha
#>           tshas are cast from clay. Modern examples , such as those
#>           made for the tourist trade in Tibet, are made of plaster
#>           and cast from ancient (1100-1200) molds and hand colored to
#>           give them the appearance of age.
```

Get metadata for many objects


```r
lapply(c(17150,17140,17144), aam)
#> [[1]]
#> <AAM metadata> Boys sumo wrestling
#>   Object id: 2005.100.35
#>   Object name: Woodblock print
#>   Date: approx. 1769
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
#>   Department: Japanese Art
#>   Dimensions: H. 12 5/8 in x W. 5 3/4 in, H. 32.1 cm x W. 14.6 cm
#>   Label: 40 é木Ø春t信M 相'撲oVびÑSuzuki Harunobu, 1725?1770Boys sumo wrestling ( Sumō
#>           ?)c. 1769Woodblock print ( nishiki-e) Hosoban
#> 
#> [[2]]
#> <AAM metadata> Autumn Moon of Matsukaze
#>   Object id: 2005.100.25
#>   Object name: Woodblock print
#>   Date: 1768-1769
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
#>   Department: Japanese Art
#>   Dimensions: H. 12 1/2 in x W. 5 3/4 in, H. 31.7 cm x W. 14.6 cm
#>   Label: 30 é木Ø春t信M 『w流¬æ八"ª景i』x 「u松¼のÌ秋H月」vSuzuki Harunobu, 1725?1770"Autumn Moon of
#>           Matsukaze" (Matsukaze no shū ?)From Fashionable Eight Views
#>           of Noh Chants (Fū ?ū ?17681769Woodblock print
#>           (nishiki-e)Hosoban
#> 
#> [[3]]
#> <AAM metadata> Hunting for fireflies
#>   Object id: 2005.100.29
#>   Object name: Woodblock print
#>   Date: 1767-1768
#>   Artist: Suzuki HarunobuJapanese, 1724 - 1770
#>   Medium: Ink and colors on paper
#>   Credit line: Gift of the Grabhorn Ukiyo-e Collection
#>   On display?: no
#>   Collection: Prints And Drawings
#>   Department: Japanese Art
#>   Dimensions: H. 10 1/2 in x W. 8 in, H. 26.7 cm x W. 20.3 cm
#>   Label: 34 é木Ø春t信M u狩ëりèSuzuki Harunobu, 1725?1770Hunting for
#>           fireflies17671768Woodblock print ( nishiki-e) Chū ?
```

There is no search functionality yet for this source.

## Meta

* Please report any issues or bugs](https://github.com/ropensci/musemeta/issues).
* License: MIT
* Get citation information for `musemeta` in R doing `citation(package = 'musemeta')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
