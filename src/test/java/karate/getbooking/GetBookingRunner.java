package karate.getbooking;

import com.intuit.karate.junit5.Karate;

import static karate.utils.ConstantFeature.GET;

public class GetBookingRunner {

    @Karate.Test
    Karate GetBooking() {
        return Karate.run(GET).relativeTo(getClass());
    }

}