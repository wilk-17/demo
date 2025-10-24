package com.example.demo.controller;

import com.example.demo.model.Brand;
import com.example.demo.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/brand")
public class BrandController {

    @Autowired
    private BrandRepository brandRepository;

    @GetMapping
    public ResponseEntity<List<Brand>> getAllBrands() {
        List<Brand> brands = brandRepository.findAll();
        return ResponseEntity.ok(brands);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Brand> getBrandById(@PathVariable Long id) {
        Optional<Brand> brand = brandRepository.findById(id);
        return brand.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<Brand> getBrandByName(@PathVariable String name) {
        Optional<Brand> brand = brandRepository.findByName(name);
        return brand.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Brand> createBrand(@RequestBody Brand brand) {
        if (brandRepository.existsByName(brand.getName())) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
        Brand savedBrand = brandRepository.save(brand);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBrand);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Brand> updateBrand(@PathVariable Long id, @RequestBody Brand brandDetails) {
        Optional<Brand> brandOptional = brandRepository.findById(id);
        
        if (brandOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Brand brand = brandOptional.get();
        brand.setName(brandDetails.getName());
        brand.setDescription(brandDetails.getDescription());

        Brand updatedBrand = brandRepository.save(brand);
        return ResponseEntity.ok(updatedBrand);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBrand(@PathVariable Long id) {
        if (!brandRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        brandRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
