package com.example.library.service;

import com.example.library.map.BookMapper;
import com.example.library.model.Book;
import com.example.library.repo.BookRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Optional;

@Service

public class BookService {
    private BookMapper bookMapper;
    private BookRepo bookRepo;
    public BookService(BookRepo bookRepo, BookMapper bookMapper){
        this.bookRepo = bookRepo;
        this.bookMapper = bookMapper;
    }
    public Book createBook(Book bookreq){
        Book bookRes = bookRepo.save(bookreq);
        return bookRes;
    }

    public Book getBook(Long id){
        Optional<Book> bookRes = bookRepo.findById(id);
        if (bookRes.isPresent()){
            return bookRes.get();
        }
        else {
            return null;
        }

    }

    public List<Book> getallBook(){
        List<Book> bookRes = bookRepo.findAll();
        if (bookRes.isEmpty()){
            return null;
        }
        else {
            return bookRes;
        }
    }

    public Book updateBook(Long id,Book bookdetails){
        Optional<Book> bookavail = bookRepo.findById(id);
        if (bookavail.isEmpty()) {
            return null;
        }
        Book bookexist = bookavail.get();
        bookMapper.updateBookfromDTO(bookdetails,bookexist);
        return bookRepo.save(bookexist);
    }

    public Book deleteBook(Long id){
        Optional<Book> bookavail = bookRepo.findById(id);

        if (bookavail.isEmpty()) {
            return null;
        }

        Book bookexist = bookavail.get();
        bookRepo.deleteById(id);

        return bookexist;
    }
}
