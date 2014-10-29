CountryReverseGeoCoder
======================

Object-C library for converting latitude and longitude coordinates into ISO 3166-1 two letter country codes.

##Usage

The lib is easy to use, example:

    CountryReverseGeoCoder *op = [[CountryReverseGeoCoder alloc]init];
    NSString *code = [op getCountryCodeByLatitude:39.903416 andLongitude:116.331053];

##Known Issues

The init of CountryReverseGeoCoder need about 11 sec, and the instance of CountryReverseGeoCoder cost 10M memory. Because the boundary data of countries is really large. I'll try to optimize it.

##Dataset

This library uses the world borders dataset from [thematicmapping.org](http://thematicmapping.org/downloads/world_borders.php). The data is stored in a properties file within the jar file that maps country codes to Well Known Text format polygons and multi-polygons. The dataset was converted to Well Known Text format by [GIS Stack Exchange user, elrobis](http://gis.stackexchange.com/a/17441).

##Reference

This repository refers a java rep, whose url is list below:

[Reverse Country Code](https://github.com/bencampion/reverse-country-code)
