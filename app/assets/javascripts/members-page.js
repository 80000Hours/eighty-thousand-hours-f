function showLoadingIcon(){var e="<div class='loading-icon'><img src='/assets/images/load.gif'></img></div>";$(e).insertBefore("#members-list"),$("#members-list").hide()}var fireCount2=0;$(document).ready(function(){fireCount2++;if(fireCount2>1){var e=$("#data-search").data("redirect-to-search");if(e==1){var t=$("#data-search").data("advanced-search");$("#form-search").submit(),t==1&&($("#advanced-search").trigger("click"),showLoadingIcon())}$("#members-list").pageless({totalPages:100,url:"/members/get_more_members",loaderImg:"/images/load.gif",distance:"2500"}),$("#search-btn").click(function(){showLoadingIcon()}),$("#members-list .profile-teaser").each(function(){var e=$(this).find(".heading").find("a").attr("onClick");$(this).find(".background").find("a").attr("onClick",e)})}});