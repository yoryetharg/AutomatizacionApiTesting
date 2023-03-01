package karate.createbooking;

import com.intuit.karate.junit5.Karate;

import static karate.utils.ConstantFeature.CREATE;

public class CreateBookingRunner {

    @Karate.Test
    Karate CreateBooking() {
        return Karate.run(CREATE).relativeTo(getClass());
    }
}