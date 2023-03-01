package karate.updatebooking;

import com.intuit.karate.junit5.Karate;

import static karate.utils.ConstantFeature.UPDATE;

public class UpdateBookingRunner {
    @Karate.Test
    Karate UpdateBooking() {
        return Karate.run(UPDATE).relativeTo(getClass());
    }
}
