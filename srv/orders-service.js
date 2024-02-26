const cds = require('@sap/cds');
const { calcOrderId, calcItemId, calcTotalPrice } = require('./lib/helper');

class OrdersService extends cds.ApplicationService {
    async init() {
        const { Products, Orders, Items } = this.entities;

        this.before('NEW', Orders, async (req) => {
            req.data.id = await calcOrderId(req);
        });

        this.before('NEW', Items, async (req) => {
            req.data.id = await calcItemId(req);
        });

        // each = shortcut für "per-row handler"
        // ansonsten: for(let each of products) {...}
        this.after('READ', Products, (each) => {
            if (each.rating <= 4.5) each.rating += 0.5;
        });

        this.after(['CREATE', 'UPDATE'], Orders, async (data, req) => {
            if (data.to_Items) {
                // accumulate prices from products from items
                const totalPrice = await calcTotalPrice(data.to_Items, Products);

                // update new total price
                data.totalPrice = totalPrice;
                const { id } = req.data;
                const n = await UPDATE(Orders, { id }).with({ totalPrice });

                // or return an error as 409 Conflict
                n > 0 || req.error(409, `Order ${id} could not be updated!`);
            }
        });

        this.after('READ', Items, (data) => {
            if (data.product && data.totalPrice === null)
                data.totalPrice = (data.product.price || 0) * data.quantity || 0;
        });

        await super.init();
    }
}

module.exports = OrdersService;
