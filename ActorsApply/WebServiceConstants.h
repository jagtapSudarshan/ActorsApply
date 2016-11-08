//
//  WebServiceConstants.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/10/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#ifndef WebServiceConstants_h
#define WebServiceConstants_h

#define BASE_URL            @"http://app.actorsapply.com/index.php/v1/"

#define LOGIN               @"auth/login"
#define AUDITION            @"audition/audition"
#define TUTORIAL_LIST       @"tutorial/tutorialList"
#define TUTORIAL            @"tutorial/tutorial/"
#define PROFILE             @"user/profile/"
#define INBOX               @"inbox/getInbox"
#define CASTING_INIT        @"casting/init"
#define CASTING_POST        @"casting/postCasting"
#define VIEW_APPLICANT      @"casting/getProjects"
#define GET_APPLICATIONS    @"casting/getApplications"
#define APPLY_AUDITION      @"audition/applyForAudition"
#define REGISTRATION        @"user/register"
#define GET_OTP             @"user/getOtp"
#define VERIFY_OTP          @"user/verifyOtp"
#define GET_SUBMISSSION     @"audition/submissions"
#define SHORTLISTED         @"casting/shortlist/"

#define UPDATE_PROJECTS     @"user/actorProjects"     // Method : put
#define DELETE_PROJECTS     @"user/actorProjects"    // Method : delete
#define GET_PROJECTS        @"user/actorProjects"    // Get

#define UPDATE_USER_PROFILE  @"user/updateUser"

#define INBOX_COMPOSE       @"inbox/compose"     // POST
#define GETINBOX_SENT       @"inbox/getInbox/sent"
#define UPLOAD_PHOTO        @"user/addPhoto"
#define UPLOAD_VIDEO        @"user/addVideo"
#define SET_PROFILE_PIC     @"user/setProfilePic"   // PUT

#define IMAGE_URL         @"http://www.actorsapply.com/app/webroot/img/photos/"
#define BLOG_IMAGE_URL    @"http://www.actorsapply.com/img/blog/"
#define PRIVACY_URL       @"http://www.actorsapply.com/privacy-policy.html"
#define TERMS_URL         @"http://www.actorsapply.com/terms-conditions.html"
#define ABOUT_URL         @"http://www.actorsapply.com/about-us.html"

#define TAB_1           1
#define TAB_2           2
#define TAB_3           3

#endif /* WebServiceConstants_h */
