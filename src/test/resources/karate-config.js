function fn() {
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    karate.configure('ssl', true);

    return {
        api: {
           baseUrl: 'https://restful-booker.herokuapp.com/booking',
           baseUrlGeneral: 'https://restful-booker.herokuapp.com/'
        }
    };
}