# [H—>O] Beacon Handovers for Data Delivery

While the Beacon v1 response was restricted to aggregate data and Beacon v2 itself provides
schemas for structuring response objects (e.g. henomic variation  or biosample data) 
the protocol can be expanded by providing custom access methods to data elements
matched by a Beacon query. Since November 2018, Beacon v1.n has included support for a "handover" protocol,
in which rich data content can be provided from linked services, initiated through a Beacon query[^1].

Typical examples of `Handover` use include:

* access to restricted data, in which a handover URL points to data behind an authentication service
or Firewall
* delivery of large/binary datasets, e.g. original array data or BAM files for a given analysis
* asynchronous calls in which a front-end follows handover URLs for additional data

## Examples

### Download variants in VCF format

In the following example a minimal boolean response is shown which contains
a single handover in the general `resultsHandovers` list.

```json
{
	"meta": {
		...
	},
	"responseSummary": {
		"exists": true
	},
	"resultsHandovers": [
		{
			"handoverType": {
				"id": "EDAM:3016",
        		"label": "VCF"
			},
			"url": "https://my.genomeserver.space/data/vcf/grch38/gizsgf8oaoiteowgfdhhpoiuy/variants.vcf",
			"note": "VCFv4.4 file with sample mapped variants (authentication required)"
		}
	]
}
```

[^1]: An early discussion of the topic can e.g. be found in the Beacon developer area on [Github](https://github.com/ga4gh-beacon/specification/issues/114). As of 2018-11-13, the __handover__ concept had become part of the [code development](https://github.com/ga4gh-beacon/specification/pull/230/files).

