type Products = {
    name: string;
    description: string;
}

type ProductsProps = {
    products: Products[];
}

export default function Products({products}:ProductsProps){
    return (
        <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">

        <ul>
            {products.map((product) => (
                <li key={product.name}> {product.name} </li>
                    ))}
        </ul>
        </div>
    );
}