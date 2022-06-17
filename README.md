# Hotel Bookings Data Analysis

<!-- wp:buttons -->
<div class="wp-block-buttons"><!-- wp:button -->
<div class="wp-block-button"><a class="wp-block-button__link" href="https://hotel-booking-analysis.shinyapps.io/Hotel_Bookings_Shiny/" target="_blank" rel="noreferrer noopener">Shiny App</a></div>
<!-- /wp:button -->

<!-- wp:button -->
<div class="wp-block-button"><a class="wp-block-button__link" href="https://github.com/suhitasva" target="_blank" rel="noreferrer noopener">GitHub</a></div>
<!-- /wp:button -->

<!-- wp:button -->
<div class="wp-block-button"><a class="wp-block-button__link" href="http://www.linkedin.com/in/suhita-acharya" target="_blank" rel="noreferrer noopener">LinkedIn</a></div>
<!-- /wp:button --></div>
<!-- /wp:buttons -->

<!-- wp:heading {"level":1} -->
<h1>Introduction</h1>
<!-- /wp:heading -->

<!-- wp:spacer {"height":"28px"} -->
<div style="height:28px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->

<!-- wp:paragraph -->
<p>When running a successful and demanding hospitality business, most hotel owners like a hotel that is running at full capacity and bringing in sizeable revenue. Most of the time hotel booking cancellations can be hurtful to business owners; although sometimes there are genuine reasons for guests to do so. These last-minute cancellations can result in lost revenue unless some measures are undertaken to mitigate the loss. The purpose of this project is to analyze Hotel Bookings data, investigate cancellations, and their underlying patterns; and suggest measures that can be implemented to reduce cancellations and secure revenue.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>As per an <a href="https://partner.booking.com/en-us/help/guides/how-better-understand-prevent-and-reduce-cancellations" target="_blank" rel="noreferrer noopener" title="article">article</a> written on Booking.com, the first thing that hotel owners can do is to take a closer look at their property’s specific cancellation patterns and understand guest behavior patterns. Backed by this research Benjamin Verot suggests in his article <a href="https://www.hotelminder.com/8-tips-to-reduce-last-minute-hotel-cancellations-and-no-shows" target="_blank" rel="noreferrer noopener" title="8 Tips to Reduce Last Minute Hotel Cancellations and No Shows">8 Tips to Reduce Last Minute Hotel Cancellations and No Shows</a> some steps that owners can execute while setting up a robust cancellation policy.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Requiring credit/debit card deposits</li><li>Using length of stay restrictions</li><li>Offering low rates/discounts for direct bookings</li><li>Adopting a cautious overbooking strategy</li></ul>
<!-- /wp:list -->

<!-- wp:heading -->
<h2>Dataset Introduction</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>For this project, I used R and Shiny to create an app that will assist in a cancellation pattern study with the intention of aiding hotel owners in reducing cancellations. The data used for this project originally came from a scientific study and an <a href="https://www.sciencedirect.com/science/article/pii/S2352340918315191" target="_blank" rel="noreferrer noopener" title="article">article</a> based on the findings - Hotel booking demand datasets; by Nuno Antonio, Ana Almeida, and Luis Nunes for Data in Brief, Volume 22, February 2019. The data was hosted on Kaggle - <a href="https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand" target="_blank" rel="noreferrer noopener" title="Hotel booking demand">Hotel booking demand</a> by Jesse Mostipak.</p>
<!-- /wp:paragraph -->

<!-- wp:gallery {"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-default is-cropped"><!-- wp:image {"id":85475,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img3-435058-ZPRfdrbs-1024x495.png" alt="" class="wp-image-85475"/></figure>
<!-- /wp:image -->

<!-- wp:image {"id":85476,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img4-910393-nic8MDPB-1024x495.png" alt="" class="wp-image-85476"/></figure>
<!-- /wp:image --><figcaption class="blocks-gallery-caption"><strong>Shiny App preview</strong></figcaption></figure>
<!-- /wp:gallery -->

<!-- wp:paragraph -->
<p>This dataset includes information about two different types of hotels (City and Resort) and whether the bookings were canceled. Each observation is a hotel booking and includes information such as arrival date, nights stated, number of adults/children staying, etc. For this project the topics that I studied are listed below:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Deposits paid by the guests</li><li>How and platform from which the bookings were made</li><li>Guests that are cancelling most often</li><li>Average daily rates</li><li>Cancellation trends during a particular year </li></ul>
<!-- /wp:list -->

<!-- wp:heading -->
<h2>Cancelled/Non-Cancelled Bookings:</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>For this project, the first thing that I examined was the cancelled and non-cancelled bookings for the City Hotel and the Resort Hotel. </p>
<!-- /wp:paragraph -->

<!-- wp:gallery {"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-default is-cropped"><!-- wp:image {"id":85464,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img1-903616-YYuEfWno.png" alt="" class="wp-image-85464"/></figure>
<!-- /wp:image --></figure>
<!-- /wp:gallery -->

<!-- wp:paragraph -->
<p>After analyzing the data, we can see that the cancelled vs non-cancelled bookings ratios are different for the different types of hotels. For the City Hotel, 58.28% of the bookings were non-cancelled vs 41.72% of the bookings that were cancelled, forming a majority.&nbsp; In contrast, for the Resort Hotel, 72.24% of the bookings were non-cancelled whereas 27.76% of the bookings were cancelled. Although, most of the bookings were not cancelled for both hotels; the point to note here is the difference in those numbers for both hotel types.</p>
<!-- /wp:paragraph -->

<!-- wp:gallery {"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-default is-cropped"><!-- wp:image {"id":85474,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img2-309495-pp7gC13b.png" alt="" class="wp-image-85474"/></figure>
<!-- /wp:image --></figure>
<!-- /wp:gallery -->

<!-- wp:heading -->
<h2>Booking Deposit Type</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Next, I looked at total cancelled and non-cancelled bookings (both hotel types) and the numbers were split by different deposit types. In this dataset, we the bookings have three different deposit types which are:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>No Deposit: no deposit was made</li><li>Refundable: a deposit was made in the value of the total stay cost</li><li>Non-Refundable: a deposit was made with a value under the total cost of stay</li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":85485,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img6-112643-OABD7gyR.png" alt="" class="wp-image-85485"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>When we look at the bookings that were not canceled per deposit type (majority of the total bookings) we see those bookings with no deposit taken, form the majority. There is a massive difference between no deposit bookings and the other types. Similarly, if we look at all the canceled bookings per deposit type, we can see that the bookings with no deposit collected for the majority, although the difference is not as pronounced in this case.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85483,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img5-396473-zdCdp0aK.png" alt="" class="wp-image-85483"/></figure>
<!-- /wp:image -->

<!-- wp:heading -->
<h2>Hotel Distribution Type</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>For the next evaluation, I looked at canceled bookings and the average daily rate per hotel distribution type. The hotel distribution channel is defined as the platform on which the hotel booking is made. This dataset provides us with four different types of distribution types.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>TA/TO: Booking made via third-party platforms such as Orbitz, Expedia, etc.</li><li>Direct booking: Booking is directly made through the hotel.</li><li>Corporate: Booking made by a large company or group.</li><li>GDS: no definition for this class is provided; bookings made through this channel are minimal.</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>First, when we look at the total canceled bookings, we can see that most of these bookings are coming from third-party booking platforms (TA/TO) for both hotel types.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85497,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img7-022705-S9tKwQks.png" alt="" class="wp-image-85497"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>For the canceled bookings there is also some difference between the average daily rates (ADR) for two different types of hotels. The rates were generally a bit higher for the direct booking channel than the third-party booking channel. For this evaluation, the bookings that had ADR above 400 were excluded.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85499,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img8-245799-RnATqaGA.png" alt="" class="wp-image-85499"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The last thing in this evaluation section that I looked at was the distribution of rates for cancelled and non-cancelled bookings per distribution type only for just the City hotel. The reason City hotel was chosen was because its total bookings were higher than the Resort hotel. Generally, the distribution of the ADRs seems consistent regardless of the cancellation status, distribution type, or hotel type.</p>
<!-- /wp:paragraph -->

<!-- wp:gallery {"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-default is-cropped"><!-- wp:image {"id":85503,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img9-558825-c1bOGWnR.png" alt="" class="wp-image-85503"/></figure>
<!-- /wp:image -->

<!-- wp:image {"id":85502,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img10-675187-Yn0cknQ2.png" alt="" class="wp-image-85502"/></figure>
<!-- /wp:image --></figure>
<!-- /wp:gallery -->

<!-- wp:heading -->
<h2>Repeat/Non-Repeat Guests</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>In this project I also evaluated total, and weekday/weeknight cancelled bookings between repeat and non-repeat guests for both hotel types. In this data, repeat guests are binary encoded as 1 and the non-repeat guests are encoded as 0.</p>
<!-- /wp:paragraph -->

<!-- wp:gallery {"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-default is-cropped"><!-- wp:image {"id":85505,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img1-026661-3N6I2eYa.png" alt="" class="wp-image-85505"/></figure>
<!-- /wp:image -->

<!-- wp:image {"id":85506,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img2-708588-MWrwvW6G.png" alt="" class="wp-image-85506"/></figure>
<!-- /wp:image --></figure>
<!-- /wp:gallery -->

<!-- wp:paragraph -->
<p>The tree maps shown above show that, although most of the bookings for the city and the resort hotel are coming from the non-repeat guests the margin of repeat bookings vs non-repeat bookings is evident to be much narrower for the cancelled bookings.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85507,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img3-130000-6FBJefLg.png" alt="" class="wp-image-85507"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>I also researched in all of the canceled bookings; the bookings made for weekday/weekend nights. What we can ascertain from the graphs above is that for both repeat and non-repeat guests (and for both hotel types) weekday night bookings are higher than the weekend night bookings.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Monthly Cancelations and Average Daily Rate (ADR)</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>In the last evaluation conducted on this data, I narrowed down the data for one year. For all the 12 months of that year, I looked at average cancelations and ADR. I did this compilation for both the City and the Resort Hotel. In this blog, we will look at the analysis results for the City Hotel. The graphs show the cancellations and ADR for just the direct bookings versus bookings of all other distribution types.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85512,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img4-806542-twMV18hw.png" alt="" class="wp-image-85512"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>For the City Hotel, if we look at the data for all distribution types other than Direct bookings; we will see that average cancelations and daily rates are higher during certain months than in others. It also looks like some of the months that have high average cancellations also have high ADRs. It is much harder to come up with a similar conclusion if we look at the data below which shows the data analysis results for the direct city hotel bookings only.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":85513,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="https://nycdsa-blog-files.s3.us-east-2.amazonaws.com/2022/06/suhita-acharya/img5-346153-4IIUA6O6.png" alt="" class="wp-image-85513"/></figure>
<!-- /wp:image -->

<!-- wp:heading {"level":1} -->
<h1>Conclusions </h1>
<!-- /wp:heading -->

<!-- wp:list -->
<ul><li>The cancelled vs. non-cancelled bookings ratio for City Hotel was different than Resort Hotel. It can be established that the type of hotel can play a factor while determining reasons for cancellations.</li><li>The majority of bookings for both hotels had no deposit collected (rather than partial or full). The same majority is demonstrated in cancelled bookings for both hotels as well.<ul><li>If we just look at non-cancelled bookings data, we can conclude that if people were to cancel more, the majority of the cancellations would be the ones with no deposit collected.</li><li>It is possible that guests tend to cancel less after paying some deposit. Some sort of deposit collection (partial or full or credit card detail requirement) at booking may reduce overall cancellations.</li></ul></li><li>Third-party cancellations are higher than direct hotel bookings, although there is no significant difference in average daily rates.<ul><li>More direct hotel bookings (with offers/discounts) could lead to lower cancellations. The data does not point to an ideal daily rate to use.</li></ul></li><li>Non-repeat guests make most of the cancelled and non-cancelled bookings (especially weekday bookings).<ul><li>Conversion of non-repeat to repeat loyal customer base (staying during the week) could lead to lower cancellations.</li></ul></li><li>For non-direct bookings (majority of cancellations - City Hotel), months with higher cancellations generally had a higher average daily rate. The same cannot be proved conclusively for direct bookings.</li></ul>
<!-- /wp:list -->

<!-- wp:heading {"level":1} -->
<h1>Future work</h1>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>As for future work, something that I would really like to work on this the app itself. With more data, I would love to make the app more dynamic and useful. I would like the app to show a rigorous analysis of all their bookings and make recommendations. Furthermore, I would like to research more into the effect of length of stays, advance purchase requirement, and overbooking on cancellations and incorporate this information in the app as well. </p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>References:</h2>
<!-- /wp:heading -->

<!-- wp:list -->
<ul><li>Booking.com for Partners. 2021.&nbsp;<em>How to better understand, prevent, and reduce cancellations</em>. [online] Available at: &lt;https://partner.booking.com/en-us/help/guides/how-better-understand-prevent-and-reduce-cancellations&gt; [Accessed 16 June 2022].</li><li>Verot, B., 2021.&nbsp;<em>8 Tips to Reduce Last Minute Hotel Cancellations and No Shows</em>. [online] Hotelminder.com. Available at: &lt;https://www.hotelminder.com/8-tips-to-reduce-last-minute-hotel-cancellations-and-no-shows&gt; [Accessed 16 June 2022].</li><li>Antonio, N., de Almeida, A. and Nunes, L., 2019. Hotel booking demand datasets.&nbsp;<em>Data in Brief</em>, [online] 22, pp.41-49. Available at: &lt;https://www.sciencedirect.com/science/article/pii/S2352340918315191&gt; [Accessed 15 June 2022].</li><li>Mostipak, J., 2020.&nbsp;<em>Hotel booking demand</em>. [online] Kaggle.com. Available at: &lt;https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand&gt; [Accessed 16 June 2022].</li></ul>
<!-- /wp:list -->
