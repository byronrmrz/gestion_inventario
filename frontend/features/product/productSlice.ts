import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { fetchProducts } from "./productApi";

type Product = {
    product_id: number;
    sku: string;
    name: string;
    price: number;
    description: string;
    createdDate: string;
}

type ProductsState = {
    products: Product[];
}

const initialState: ProductsState = {
    products: []
}

export const fetchProductsThunk = createAsyncThunk("product/fetchProducts", async () => {
    return await fetchProducts();
})

const productSlice = createSlice({
    name: 'product',
    initialState,
    reducers: {
        addProducts: (state, action) => {
            state.products = action.payload;
        },
        addProduct: (state, action) => {
            state.products.push(action.payload);
        },
        removeProduct: (state, action) => {
            state.products = state.products.filter(product => product.product_id !== action.payload);
        }
    },
    extraReducers : (builder) => {
        builder.addCase( fetchProductsThunk.fulfilled, (state, action) => {
            state.products = action.payload;
        });
    }
});

export const { addProducts, addProduct, removeProduct } = productSlice.actions;
export default productSlice.reducer;  // export the reducer to be used in the store.  // eslint-disabl