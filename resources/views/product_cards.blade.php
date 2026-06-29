@foreach($products as $p)
<!-- LOGIKA SUPER CERDAS: Cek dari variabel ATAU langsung baca dari URL -->
<div class="col-6 {{ (isset($selected_cats) && in_array('all', $selected_cats)) || request()->is('products/category/all') ? 'col-md-3' : 'col-md-4' }} product-item mb-4">
    <a href="{{ url('product/'.$p->id) }}" class="product-grid-card shadow-sm">
        <div class="product-img-box">
            <img src="{{ asset('assets/img/'.$p->name.'.png') }}" 
                 onerror="this.onerror=null; this.src='{{ asset('assets/img/default_part.png') }}';" 
                 alt="{{ $p->name }}"
                 class="img-fluid">
        </div>
        <div class="product-name">{{ $p->name }}</div>
        <div class="product-price">Rp {{ number_format($p->price, 0, ',', '.') }}</div>
    </a>
</div>
@endforeach