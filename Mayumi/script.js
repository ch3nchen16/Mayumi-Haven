let sections = document.querySelectorAll('section');
let navlinks = document.querySelectorAll('nav li a');

window.onscroll = () => {
    sections.forEach(sec => {
        let top = window.scrollY;
        let offset = sec.offsetTop - 150;
        let height = sec.offsetHeight;
        let id = sec.getAttribute('id');

        if (top >= offset && top < offset + height) {
            navlinks.forEach(links => {
                links.classlist.remove('active');
                document.querySelector('nav li a [href*=' + id + ']').classList.add('active');
            });
        };
    });
};

document.addEventListener('DOMContentLoaded', function () {
    const bookNavLink = document.getElementById('bookNavLink');
    const offCanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasBottom'));

    //Off-canvas will open when I click on the Book button
    bookNavLink.addEventListener('click', function (e) {
        e.preventDefault(); 
        offCanvas.show();   //shows the off-canvas
    });
});

/*The bootstrap modal won't work so I have to manually add the javascript.
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("[data-bs-toggle='modal']").forEach(button => {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            var modalID = this.getAttribute("data-bs-target");
            var modal = new bootstrap.Modal(document.querySelector(modalID));
            modal.show();
        });
    });

    //To remove the backdrop
    document.querySelectorAll("[data-bs-dismiss='modal']").forEach(closeButton => {
        closeButton.addEventListener("click", function () {
            document.querySelectorAll(".modal-backdrop").forEach(backdrop => {
                backdrop.remove();
            });
        });
    });
});
//the scroll bar keeps disappearing, this enforces it once you press the close button
document.addEventListener("hidden.bs.modal", function () {
    document.body.classList.remove("modal-open");
    document.querySelectorAll(".modal-backdrop").forEach(backdrop => backdrop.remove());
    document.body.style.overflow = "auto";
});
*/

//For the features
document.addEventListener("DOMContentLoaded", function () {
    let totalFeaturePrice = 0;
    let selectedFeatures = {}; //Stores the added features and their prices

    function addFeature(price, featureId) {
        if (selectedFeatures[featureId]) return;

        selectedFeatures[featureId] = price;
        totalFeaturePrice += price;
        updateFeaturePriceDisplay();

        let addButton = document.querySelector(`#btnAdd-${featureId}`);
        let removeButton = document.querySelector(`#btnRemove-${featureId}`);

        if (addButton) addButton.style.display = 'none';
        if (removeButton) removeButton.style.display = 'inline-block';
    }

    function removeFeature(price, featureId) {
        if (!selectedFeatures[featureId]) return;

        totalFeaturePrice -= price;
        delete selectedFeatures[featureId];
        updateFeaturePriceDisplay();

        let addButton = document.querySelector(`#btnAdd-${featureId}`);
        let removeButton = document.querySelector(`#btnRemove-${featureId}`);

        if (addButton) addButton.style.display = 'inline-block';
        if (removeButton) removeButton.style.display = 'none';
    }

    function updateFeaturePriceDisplay() {
        let lblFeaturePrice = document.querySelector("[id$='lblFeaturePrice']");
        let hiddenFeaturePrice = document.querySelector("[id$='hiddenFeaturePrice']");

        if (lblFeaturePrice) {
            lblFeaturePrice.innerText = `Total Features: €${totalFeaturePrice.toFixed(2)}`;
        }

        if (hiddenFeaturePrice) {
            hiddenFeaturePrice.value = totalFeaturePrice.toFixed(2);  
        }
    }

    
    document.body.addEventListener("click", function (event) {
        if (event.target.matches("[id^='btnAdd-']")) {
            let featureId = event.target.id.split("-")[1];
            let price = parseFloat(event.target.getAttribute("data-price"));
            addFeature(price, featureId);
        }

        if (event.target.matches("[id^='btnRemove-']")) {
            let featureId = event.target.id.split("-")[1];
            let price = parseFloat(event.target.getAttribute("data-price"));
            removeFeature(price, featureId);
        }
    });

    document.querySelector("[id$='hiddenFeaturePrice']").value = totalFeaturePrice.toFixed(2);
    
});



/* Close modal when add button is clicked
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".modal-footer button").forEach(button => {
        button.addEventListener("click", function () {
            let modalElement = button.closest(".modal");
            if (modalElement) {
                let modal = bootstrap.Modal.getInstance(modalElement);
                if (modal) modal.hide();
            }
        });
    });
});
 */
document.addEventListener("DOMContentLoaded", function () {
    const regForm = document.getElementById("regForm");
    const loginForm = document.getElementById("loginForm");
    const btnDisplayLogin = document.getElementById("btnDisplayLogin");
    const btnDisplayRegister = document.getElementById("btnDisplayRegister");

    //first shows the registration form and hide the login form
    regForm.style.display = "block";
    loginForm.style.display = "none";

    btnDisplayLogin.addEventListener("click", function (event) {
        event.preventDefault(); 
        regForm.style.display = "none";
        loginForm.style.display = "block";
    });

    btnDisplayRegister.addEventListener("click", function (event) {
        event.preventDefault(); 
        regForm.style.display = "block";
        loginForm.style.display = "none";
    });
});

//FAQs
$(document).ready(function () {
    $(".answer").hide();

    $("h4.question").click(function () {
        $(this).next(".answer").slideToggle(500); 
    });
});


