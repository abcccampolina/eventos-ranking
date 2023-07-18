//
// =========================================================
// Paper Dashboard 2 PRO - v2.0.1
// =========================================================
//
// Product Page: https://www.creative-tim.com/product/paper-dashboard-2-pro
// Copyright 2019 Creative Tim (https://www.creative-tim.com)
//
// Coded by Creative Tim
//
// =========================================================
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
require("perfect-scrollbar")

function debounce(n, t, r) {
    var o;
    return function () {
        var a = this,
            e = arguments;
        clearTimeout(o), o = setTimeout(function () {
            o = null, r || n.apply(a, e)
        }, t), r && !o && n.apply(a, e)
    }
}

function hexToRGB(a, e) {
    var n = parseInt(a.slice(1, 3), 16),
        t = parseInt(a.slice(3, 5), 16),
        r = parseInt(a.slice(5, 7), 16);
    return e ? "rgba(" + n + ", " + t + ", " + r + ", " + e + ")" : "rgb(" + n + ", " + t + ", " + r + ")"
}
transparent = !0, transparentDemo = !0, fixedTop = !1, navbar_initialized = !1, backgroundOrange = !1, sidebar_mini_active = !1, toggle_initialized = !1, seq = 0, delays = 80, durations = 500, seq2 = 0, delays2 = 80, durations2 = 500, isWindows = -1 < navigator.platform.indexOf("Win"), isWindows ? ($("html").addClass("perfect-scrollbar-on")) : $("html").addClass("perfect-scrollbar-off"), $(document).ready(function () {
    $('[data-toggle="tooltip"], [rel="tooltip"]').tooltip(), $('[data-toggle="popover"]').each(function () {
        color_class = $(this).data("color"), $(this).popover({
            template: '<div class="popover popover-' + color_class + '" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
        })
    });
    var a = $(".tagsinput").data("color");
    0 != $(".tagsinput").length && $(".tagsinput").tagsinput(), $(".bootstrap-tagsinput").addClass(a + "-badge"), 0 != $(".selectpicker").length && $(".selectpicker").selectpicker({
        iconBase: "nc-icon",
        tickIcon: "nc-check-2"
    }), 0 != $(".modal").length && $(".modal").appendTo("body"), 0 == $(".full-screen-map").length && 0 == $(".bd-docs").length && $(".collapse").on("show.bs.collapse", function () {
        $(this).closest(".navbar").removeClass("navbar-transparent").addClass("bg-white")
    }).on("hide.bs.collapse", function () {
        $(this).closest(".navbar").addClass("navbar-transparent").removeClass("bg-white")
    }), paperDashboard.initMinimizeSidebar(), $navbar = $(".navbar[color-on-scroll]"), scroll_distance = $navbar.attr("color-on-scroll") || 500, 0 != $(".navbar[color-on-scroll]").length && (paperDashboard.checkScrollForTransparentNavbar(), $(window).on("scroll", paperDashboard.checkScrollForTransparentNavbar)), $(".form-control").on("focus", function () {
        $(this).parent(".input-group").addClass("input-group-focus")
    }).on("blur", function () {
        $(this).parent(".input-group").removeClass("input-group-focus")
    }), $(".bootstrap-switch").each(function () {
        $this = $(this), data_on_label = $this.data("on-label") || "", data_off_label = $this.data("off-label") || "", $this.bootstrapSwitch({
            onText: data_on_label,
            offText: data_off_label
        })
    })
}), $(document).on("click", ".navbar-toggle", function () {
    $toggle = $(this), 1 == paperDashboard.misc.navbar_menu_visible ? ($("html").removeClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 0, setTimeout(function () {
        $toggle.removeClass("toggled"), $("#bodyClick").remove()
    }, 550)) : (setTimeout(function () {
        $toggle.addClass("toggled")
    }, 580), div = '<div id="bodyClick" data-turbolinks-permanent></div>', $(div).appendTo("body").click(function () {
        $("html").removeClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 0, setTimeout(function () {
            $toggle.removeClass("toggled"), $("#bodyClick").remove()
        }, 550)
    }), $("html").addClass("nav-open"), paperDashboard.misc.navbar_menu_visible = 1)
}), $(window).resize(function () {
    seq = seq2 = 0, 0 == $(".full-screen-map").length && 0 == $(".bd-docs").length && ($navbar = $(".navbar"), isExpanded = $(".navbar").find('[data-toggle="collapse"]').attr("aria-expanded"), $navbar.hasClass("bg-white") && 991 < $(window).width() ? $navbar.removeClass("bg-white").addClass("navbar-transparent") : $navbar.hasClass("navbar-transparent") && $(window).width() < 991 && "false" != isExpanded && $navbar.addClass("bg-white").removeClass("navbar-transparent"))
}), paperDashboard = {
    misc: {
        navbar_menu_visible: 0
    },
    checkScrollForTransparentNavbar: debounce(function () {
        $(document).scrollTop() > scroll_distance ? transparent && (transparent = !1, $(".navbar[color-on-scroll]").removeClass("navbar-transparent")) : transparent || (transparent = !0, $(".navbar[color-on-scroll]").addClass("navbar-transparent"))
    }, 17),
    checkSidebarImage: function () {
        $sidebar = $(".sidebar"), image_src = $sidebar.data("image"), void 0 !== image_src && (sidebar_container = '<div class="sidebar-background" style="background-image: url(' + image_src + ') "/>', $sidebar.append(sidebar_container))
    },
    initMinimizeSidebar: function () {
        $("#minimizeSidebar").click(function () {
            $(this);
            1 == paperDashboard.misc.sidebar_mini_active ? ($("body").removeClass("sidebar-mini"), paperDashboard.misc.sidebar_mini_active = !1) : ($("body").addClass("sidebar-mini"), paperDashboard.misc.sidebar_mini_active = !0);
            var a = setInterval(function () {
                window.dispatchEvent(new Event("resize"))
            }, 180);
            setTimeout(function () {
                clearInterval(a)
            }, 1e3)
        })
    },
    startAnimationForLineChart: function (a) {
        a.on("draw", function (a) {
            "line" === a.type || "area" === a.type ? a.element.animate({
                d: {
                    begin: 600,
                    dur: 700,
                    from: a.path.clone().scale(1, 0).translate(0, a.chartRect.height()).stringify(),
                    to: a.path.clone().stringify(),
                    easing: Chartist.Svg.Easing.easeOutQuint
                }
            }) : "point" === a.type && (seq++, a.element.animate({
                opacity: {
                    begin: seq * delays,
                    dur: durations,
                    from: 0,
                    to: 1,
                    easing: "ease"
                }
            }))
        }), seq = 0
    },
    startAnimationForBarChart: function (a) {
        a.on("draw", function (a) {
            "bar" === a.type && (seq2++, a.element.animate({
                opacity: {
                    begin: seq2 * delays2,
                    dur: durations2,
                    from: 0,
                    to: 1,
                    easing: "ease"
                }
            }))
        }), seq2 = 0
    },
    showSidebarMessage: function (a) {
        try {
            $.notify({
                icon: "nc-icon nc-bell-55",
                message: a
            }, {
                type: "info",
                timer: 4e3,
                placement: {
                    from: "top",
                    align: "right"
                }
            })
        } catch (a) {
            console.log("Notify library is missing, please make sure you have the notifications library added.")
        }
    }
};
//# sourceMappingURL=_site_dashboard_pro/assets/js/dashboard-pro.js.map