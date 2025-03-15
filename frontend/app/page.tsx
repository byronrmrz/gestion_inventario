'use client'
import Image from "next/image";
import { useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";
import { fetchProductsThunk } from "@/features/product/productSlice";
import { AppState, AppDispatch} from "../Redux/store";
import Products from "./product";



export default function Home() {
  const dispatch = useDispatch<AppDispatch>();
  useSelector ((state: AppState) => state.product.products);
  useEffect(() => {
    dispatch(fetchProductsThunk());
    }, [dispatch]);

  return (
    < Products productos={producto} />
  );
}
