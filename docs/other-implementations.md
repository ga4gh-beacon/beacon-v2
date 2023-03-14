## Registry Server

The Beacon registry server, hosted through the European Genome-Phenome Archive, monitors
a number of implementations of the Beacon v2 protocol by various organisations actively involved
in Beacon protocol development.

##### Link: [Beacon v2 GA4GH Approval Registry](https://ga4gh-approval-service-registry-demo.ega-archive.org)

## Example Implementations

### Progenetix API

The Progenetix database and cancer genomic information resource contains genome profiles
of more than 140000 individual cancer genome screening experiments, with the majority
representing results from genomic copy number assessment studies. With its
Beacon<span style="color: red; font-weight: 800;"><sup>+</sup></span> forward-looking test
implementation, since 2016 Progenetix has been developing concepts for Beacon protocol extensions
such as CNV query options or handover data delivery.

#### Technologies

* MongoDB backend
* [`bycon`](http://github.com/progenetix/bycon/) Python-based full stack API / middleware
* [`progenetix-web`](http://github.com/progenetix/progenetix-web/) React based front-end (modular for Beacon instances as well as the whole Progenetix UI)

##### Link: [Documentation page]([implementations/org.progenetix.md](https://docs.progenetix.org/beaconplus/#beacon-v2-path-examples-in-progenetix)) for Progenetix REST paths

### Cafe Variome

##### Link: [Cafe Variome](https://beaconv2.cafevariome.org/form)

### CNAG Beacon v2 API

##### Link: [CNAG Beacon v2 API](https://playground.rd-connect.eu/beacon2/api)

### Fundacion Progreso y Salud Beacon v2 API

##### Link: [Fundacion Progreso y Salud Beacon v2 API](https://csvs-beacon.clinbioinfosspa.es/csvs/ga4ghbeacon/v2/api/)

## Tips for New Implementers

Find below some tips to get you started:

1. Start with a [boolean](beacon-flavours.md) beacon.
2. List your available [endpoints](framework.md).
3. Map the data from your DB to the [Models](models.md) {{config.repo_models_icon}}.
4. Handle the different types of [filters](filters.md) and [request parameters](framework.md).
5. Build a response following the [Framework](framework.md) {{config.repo_framework_icon}}.
