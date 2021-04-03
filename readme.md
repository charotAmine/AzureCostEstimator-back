# Azure Cost Estimator

Azure Cost Estimator is a free service for cost estimation. It is an open-source project.

It is compatible with Terraform and ARM Templates.

Note : this is not an official Microsoft Project

## Getting Started

Upload a JSON file. to get it you need to run

```
terraform plan -out examplefile.tfplan
```

```
terraform show -json examplefile.tfplan | Out-File myf.json
```

Note : The example above was done using Powershell. replace ```Out-File``` if you are not using it

Once is done, upload the JSON file.

### Prerequisites

The back is developped through Powershell. So to contribute you will need it.

### Installing

If you want to test locally, you just have to download the Azure Function tools.
After your development, run : 

```
func start azurecostestimator-general -port 7071
```
Which will run the function locally with the following url : 

```
azurecostestimator-general: [GET,POST] http://localhost:7071/api/azurecostestimator-general
```

then just run a POST Request with the JSON File as body got through : 

```
terraform plan -out examplefile.tfplan
```

```
terraform show -json examplefile.tfplan | Out-File myf.json
```

```
$test = iwr "https://prices.azure.com/api/retail/prices"
$content = $test.Content | ConvertFrom-Json
$spec = $content.Items | Where {$_.serviceName -like "*anagement*"}
if($spec -eq $null)
{
    while($content.NextPageLink)
    {
        $test = iwr $content.NextPageLink
        $content = $test.Content | ConvertFrom-Json
        $spec = $content.Items | Where {$_.serviceName -like "*anagement*"}
        if($spec)
        {
            break;
        }
    }
}
$spec
```

## Running the tests

Once you create a Pull Request, GitHub Actions run tests. You won't be able to merge if you don't have these tests green :(

### Break down into end to end tests

The idea of tests is to take the Terraform file, get the Json file and deploy a Function on Azure to test it.

![Alt text](./tests.PNG?raw=true "Test")


## Deployment

Once the tests are OK, and you got an approval, your code will be merged to a master Function : 

![Alt text](./archi.png?raw=true "Test")

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/charotAmine/AzureCostEstimator-back/tags). 

## Authors

* **Amine CHAROT** - *Initial work* - [AzureCostEstimator](https://github.com/charotAmine)

See also the list of [contributors](https://github.com/charotAmine/AzureCostEstimator-back/contributors) who participated in this project.