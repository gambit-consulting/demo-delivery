module.exports = {
    calcNewId: (maxId, step = 1) => Math.floor((maxId / step) + 1) * step,
    calcOrderId: async req => {
        const { id } = await cds.tx(req).run(SELECT.one.from(req.target).columns('max(id) as id'))
        return id + 1
    },
    calcItemId: async (req, step = 10) => {
        const { id } = await cds.tx(req).run(SELECT.one.from(req.target).where`to_Orders_id=${req.data.to_Orders_id}`.columns('max(id) as id'))
        return Math.floor((id / step) + 1) * step
    },
    calcTotalPrice: async (items, Products) => await items
        .filter(item => item.product_ID)
        .reduce(async (previous, item) => {
            const { price } = await SELECT.one`price`.from(Products).where`id=${item.product_ID}`;
            return (await previous) + (item.quantity || 1) * price;
        }, 0)
}