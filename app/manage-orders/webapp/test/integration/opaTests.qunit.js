sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'gambit/demo/delivery/manageorders/test/integration/FirstJourney',
        'gambit/demo/delivery/manageorders/test/integration/pages/OrdersList',
        'gambit/demo/delivery/manageorders/test/integration/pages/OrdersObjectPage',
        'gambit/demo/delivery/manageorders/test/integration/pages/ItemsObjectPage',
    ],
    function (JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, ItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('gambit/demo/delivery/manageorders') + '/index.html',
        });

        JourneyRunner.run(
            {
                pages: {
                    onTheOrdersList: OrdersList,
                    onTheOrdersObjectPage: OrdersObjectPage,
                    onTheItemsObjectPage: ItemsObjectPage,
                },
            },
            opaJourney.run
        );
    }
);
