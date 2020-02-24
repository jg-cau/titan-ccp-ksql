package titan.ccp.ksql;

import com.sun.org.apache.xpath.internal.functions.FuncFalse;
import io.confluent.ksql.function.udf.Udf;
import io.confluent.ksql.function.udf.UdfDescription;
import io.confluent.ksql.function.udf.UdfParameter;

import java.util.Calendar;
import java.util.Date;

@UdfDescription(name = "checkDate", description = "check date")
public class CheckDate {

  Calendar cal = Calendar.getInstance();

  @Udf(description = "check if given timestamp equals given day of the week")
  public String checkDate(
    @UdfParameter(value = "V1", description = "given timestamp") final long v1,
    @UdfParameter(value = "V2", description = "expected day of week") final String v2) {

    cal.setTime(new Date(v1));
    String isGivenDate;
    v2.toUpperCase();
    switch (v2) {
      case "MONDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY ? "True" : "False";
        break;
      case "TUESDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.TUESDAY ? "True" : "False";
        break;
      case "WEDNESDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.WEDNESDAY ? "True" : "False";
        break;
      case "THURSDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.THURSDAY ? "True" : "False";
        break;
      case "FRIDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.FRIDAY ? "True" : "False";
        break;
      case "SATURDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY ? "True" : "False";
        break;
      case "SUNDAY":
        isGivenDate = cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY ? "True" : "False";
        break;
      default:
        isGivenDate = "False";
    }
    return isGivenDate;
  }
}
