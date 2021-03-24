BeforeAll {
    function Get-Services ()
    {
        $body = Get-Content "./myfiletest.json" -raw
        $testUri = iwr -Method POST -Uri $env:FUNCTION_URL -Body $body -ContentType "application/json"
        return $testUri.Content | convertFrom-Json
    }

    function Get-numberOfServices ()
    {
        $jsonFile = (Get-Content "./myfiletest.json" -raw) | ConvertFrom-Json
        $withoutRG = $jsonFile.resource_changes.Count - 1
        return $withoutRG
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