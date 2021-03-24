BeforeAll {
    function Get-Services ()
    {
        $body = Get-Content "./myfiletest.json" -raw
        $testUri = iwr -Method POST -Uri $env:FUNCTION_URL -Body $body -ContentType "application/json"
        return $testUri.Content | convertFrom-Json
    }
    Function convertFrom-Terraform($body)
    {
        $list = New-Object System.Collections.ArrayList
        $tfResources = $body.resource_changes
        foreach ($resource in $tfResources) {
            $resourceType = (($resource.type).replace("azurerm_", "")).replace("_", " ")
            $res = @{"ServiceName"=$resourceType;"resourceChangement"= $resource.change.after}
            $empty = $list.Add($res)
        }
        return $list
    }
    function Get-numberOfServices ()
    {
        $jsonFile = (Get-Content "./myfiletest.json" -raw) | ConvertFrom-Json
        $resources = convertFrom-Terraform -Body $jsonFile
        $i=0
        foreach ($resource in $resources) {
            switch ($resource.ServiceName) {
                "key vault" {
                    $i++
                }
                "app service plan" {
                    $i++
                }
                "storage account" {
                    $i++
                }
                Default {}
            }
}   
        return $i
    }
}

# Pester tests
Describe 'Get-Pricing' {
  It "List all pricing" {
    $allServices = Get-Services
    $shouldBe = Get-numberOfServices
    $allServices.Count | Should -Be $shouldBe
  }
}