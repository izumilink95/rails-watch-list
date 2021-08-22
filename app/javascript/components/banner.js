import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Don't know what to watch?", "Organise your watch list now!"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };
