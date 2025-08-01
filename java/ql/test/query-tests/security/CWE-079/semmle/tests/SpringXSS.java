import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

import java.util.Optional;

@RestController
public class SpringXSS {

  @GetMapping
  public static ResponseEntity<String> specificContentType(boolean safeContentType, boolean chainDirectly, String userControlled) { // $ Source

    ResponseEntity.BodyBuilder builder = ResponseEntity.ok();

    if(!safeContentType) {
      if(chainDirectly) {
        return builder.contentType(MediaType.TEXT_HTML).body(userControlled); // $ Alert
      }
      else {
        ResponseEntity.BodyBuilder builder2 = builder.contentType(MediaType.TEXT_HTML);
        return builder2.body(userControlled); // $ Alert
      }
    }
    else {
      if(chainDirectly) {
        return builder.contentType(MediaType.APPLICATION_JSON).body(userControlled);
      }
      else {
        ResponseEntity.BodyBuilder builder2 = builder.contentType(MediaType.APPLICATION_JSON);
        return builder2.body(userControlled);
      }
    }

  }

  @GetMapping(value = "/xyz", produces = MediaType.APPLICATION_JSON_VALUE)
  public static ResponseEntity<String> methodContentTypeSafe(String userControlled) {
    return ResponseEntity.ok(userControlled);
  }

  @PostMapping(value = "/xyz", produces = MediaType.APPLICATION_JSON_VALUE)
  public static ResponseEntity<String> methodContentTypeSafePost(String userControlled) {
    return ResponseEntity.ok(userControlled);
  }

  @RequestMapping(value = "/xyz", produces = MediaType.APPLICATION_JSON_VALUE)
  public static ResponseEntity<String> methodContentTypeSafeRequest(String userControlled) {
    return ResponseEntity.ok(userControlled);
  }

  @GetMapping(value = "/xyz", produces = "application/json")
  public static ResponseEntity<String> methodContentTypeSafeStringLiteral(String userControlled) {
    return ResponseEntity.ok(userControlled);
  }

  @GetMapping(value = "/xyz", produces = MediaType.TEXT_HTML_VALUE)
  public static ResponseEntity<String> methodContentTypeUnsafe(String userControlled) { // $ Source
    return ResponseEntity.ok(userControlled); // $ Alert
  }

  @GetMapping(value = "/xyz", produces = "text/html")
  public static ResponseEntity<String> methodContentTypeUnsafeStringLiteral(String userControlled) { // $ Source
    return ResponseEntity.ok(userControlled); // $ Alert
  }

  @GetMapping(value = "/xyz", produces = {MediaType.TEXT_HTML_VALUE, MediaType.APPLICATION_JSON_VALUE})
  public static ResponseEntity<String> methodContentTypeMaybeSafe(String userControlled) { // $ Source
    return ResponseEntity.ok(userControlled); // $ Alert
  }

  @GetMapping(value = "/xyz", produces = MediaType.APPLICATION_JSON_VALUE)
  public static ResponseEntity<String> methodContentTypeSafeOverriddenWithUnsafe(String userControlled) { // $ Source
    return ResponseEntity.ok().contentType(MediaType.TEXT_HTML).body(userControlled); // $ Alert
  }

  @GetMapping(value = "/xyz", produces = MediaType.TEXT_HTML_VALUE)
  public static ResponseEntity<String> methodContentTypeUnsafeOverriddenWithSafe(String userControlled) {
    return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(userControlled);
  }

  @GetMapping(value = "/xyz", produces = {"text/html", "application/json"})
  public static ResponseEntity<String> methodContentTypeMaybeSafeStringLiterals(String userControlled, int constructionMethod) { // $ Source
    // Also try out some alternative constructors for the ResponseEntity:
    switch(constructionMethod) {
      case 0:
      return ResponseEntity.ok(userControlled); // $ Alert
      case 1:
      return ResponseEntity.of(Optional.of(userControlled)); // $ Alert
      case 2:
      return ResponseEntity.ok().body(userControlled); // $ Alert
      case 3:
      return new ResponseEntity<String>(userControlled, HttpStatus.OK); // $ Alert
      default:
      return null;
    }
  }

  @RestController
  @RequestMapping(produces = {"application/json"})
  private static class ClassContentTypeSafe {
    @GetMapping(value = "/abc")
    public ResponseEntity<String> test(String userControlled) {
      return ResponseEntity.ok(userControlled);
    }

    @GetMapping(value = "/abc")
    public String testDirectReturn(String userControlled) {
      return userControlled;
    }

    @GetMapping(value = "/xyz", produces = {"text/html"})
    public ResponseEntity<String> overridesWithUnsafe(String userControlled) { // $ Source
      return ResponseEntity.ok(userControlled); // $ Alert
    }

    @GetMapping(value = "/abc")
    public ResponseEntity<String> overridesWithUnsafe2(String userControlled) { // $ Source
      return ResponseEntity.ok().contentType(MediaType.TEXT_HTML).body(userControlled); // $ Alert
    }
  }

  @RestController
  @RequestMapping(produces = {"text/html"})
  private static class ClassContentTypeUnsafe {
    @GetMapping(value = "/abc")
    public ResponseEntity<String> test(String userControlled) { // $ Source
      return ResponseEntity.ok(userControlled); // $ Alert
    }

    @GetMapping(value = "/abc")
    public String testDirectReturn(String userControlled) { // $ Source
      return userControlled; // $ Alert
    }

    @GetMapping(value = "/xyz", produces = {"application/json"})
    public ResponseEntity<String> overridesWithSafe(String userControlled) {
      return ResponseEntity.ok(userControlled);
    }

    @GetMapping(value = "/abc")
    public ResponseEntity<String> overridesWithSafe2(String userControlled) {
      return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(userControlled);
    }
  }

  @GetMapping(value = "/abc")
  public static ResponseEntity<String> entityWithNoMediaType(String userControlled) { // $ Source
    return ResponseEntity.ok(userControlled); // $ Alert
  }

  @GetMapping(value = "/abc")
  public static String stringWithNoMediaType(String userControlled) { // $ Source
    return userControlled; // $ Alert
  }

  @GetMapping(value = "/abc")
  public static String sanitizedString(String userControlled) {
    return HtmlUtils.htmlEscape(userControlled);
  }

}
