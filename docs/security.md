# Security

!!! Warning "Disclaimer"

        A stand-alone regulatory and ethics review has been performed on the specification itself>
        However, it is the responsibility of the implementer to ensure that appropriate measures are taken
        to remove risks related to privacy, confidentiality, and/or security of data.

The Beacon uses a 3-tiered access model: `anonymous`, `registered`, and `controlled access`.

!!! Important "Technical Notes"

        For detailed information about the technical implementation of the different levels
        of security please see the [Framework](framework.md) documentation.

## Registered

For a Beacon to respond to a query at the **registered** tier, the user must identify themselves to the Beacon, for example by using an [ELIXIR identity](https://elixir-europe.org/internal-projects/commissioned-services/identity-access). 

## Controlled

For a Beacon to respond to a **controlled** access query, the user must have applied for, and been granted access to, the Beacon (or data derived from one or more individuals within the Beacon)
individuals) whose data is only accessible at specified tiers within the Beacon. This tiered access model allows the owner or controller of a Beacon to determine which responses are returned to whom depending on the query and the user who is making the request, for example to ensure the response respects the consent under which the data were collected.

## Anonymous

Anonymous Beacon can be accessed by any request.

!!! Warning "Synthetic data"

    The use of synthetic data for testing is important in that it ensures that the full functionality of a Beacon can be tested and / or demonstrated without risk of exposing data from individuals. In addition to testing or demonstrating a deployment, synthetic data should be used for development, for example when adding new features.
