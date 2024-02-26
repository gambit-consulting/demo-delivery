sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'gambit/demo/delivery/manageproducts/test/integration/FirstJourney',
        'gambit/demo/delivery/manageproducts/test/integration/pages/ProductsList',
        'gambit/demo/delivery/manageproducts/test/integration/pages/ProductsObjectPage',
    ],
    function (JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('gambit/demo/delivery/manageproducts') + '/index.html',
        });

        JourneyRunner.run(
            {
                pages: {
                    onTheProductsList: ProductsList,
                    onTheProductsObjectPage: ProductsObjectPage,
                },
            },
            opaJourney.run
        );
    }
);
