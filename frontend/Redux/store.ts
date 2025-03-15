import { configureStore } from "@reduxjs/toolkit";
import productReducer from "../features/product/productSlice"; 

export const makeStore = () => {
    return configureStore({
        reducer: {
            product : productReducer
        },
    });
};

export type AppStore = ReturnType<typeof makeStore>;
export type AppDispatch = AppStore['dispatch'];
export type AppState = ReturnType<AppStore['getState']>;

