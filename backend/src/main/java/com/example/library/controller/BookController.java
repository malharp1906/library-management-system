
package com.example.library.controller;


import com.example.library.model.Book;
import com.example.library.service.BookService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/books")
@CrossOrigin(origins = "*")
public class BookController {
    private BookService bookService;
    public BookController(BookService bookService){
        this.bookService = bookService;
    }
    @PostMapping("/create")
    public ResponseEntity<Book> addBook(@RequestBody Book book){
        Book createdBook = bookService.createBook(book);
        return ResponseEntity.status(201).body(createdBook);
    }
    @GetMapping("/read/{id}")
    public ResponseEntity<Book> getBook( @PathVariable Long id){
        Book fetchedBook = bookService.getBook(id);
        if (fetchedBook == null){
            return ResponseEntity.status(404).body(null);
        }
        else {
            return ResponseEntity.ok(fetchedBook);
        }
    }
    @GetMapping("/read")
    public ResponseEntity<List<Book>> getBooks(){
        List<Book> fetchedBook = bookService.getallBook();
        if (fetchedBook == null){
            return ResponseEntity.status(404).body(null);
        }
        else {
            return ResponseEntity.ok(fetchedBook);
        }
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<Book> updateBook( @PathVariable Long id, @RequestBody Book book){
        Book updatedBook = bookService.updateBook(id, book);
        if (updatedBook == null){
            return ResponseEntity.status(404).body(null);
        }
        else {
            return ResponseEntity.ok(updatedBook);
        }
    }
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Book> deleteBook(@PathVariable Long id){
        Book deletedBook = bookService.deleteBook(id);
        return ResponseEntity.ok(deletedBook);
    }
}