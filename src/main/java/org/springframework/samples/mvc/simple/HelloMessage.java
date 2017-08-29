package org.springframework.samples.mvc.simple;

/**
 * Created by prasadsriramula on 29/08/2017.
 */
public class HelloMessage {
    private String message;

    public HelloMessage(String message) {
        this.message = message;
    }

    public HelloMessage(){}

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
