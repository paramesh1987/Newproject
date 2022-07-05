package com.myself.sample.ws;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/docker")
public class DockerController {

  @GetMapping("/server")
  public Message getServer(){
    return new Message("TomCat");
  }

  @GetMapping("/appType")
  public Message getContainer(){
    return new Message("Docker Container");
  }

  @GetMapping("/client")
  public Message getClient(){
    return new Message("Any Browser/Curl");
  }

}
