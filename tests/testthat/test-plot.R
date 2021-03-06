context("Test plotting")

test_that("plot for incidence object", {
  skip_on_cran()

  set.seed(1)
  dat <- sample(1:50, 200, replace = TRUE, prob = 1 + exp(1:50 * 0.1))
  dat2 <- as.Date("2016-01-02") + dat
  sex <- sample(c("female", "male"), 200, replace = TRUE)

  i <- incidence(dat)
  i.3 <- incidence(dat, 3L)
  i.14 <- incidence(dat, 14L)
  i.sex <- incidence(dat, 7L, groups = sex)
  i.isoweek <- incidence(dat2, 7L, iso_week = TRUE)
  fit.i <- suppressWarnings(fit(i))
  fit.i.2 <- suppressWarnings(fit(i, split = 30))
  fit.sex <- suppressWarnings(fit(i.sex))

  p.fit.i <- plot(fit.i)
  p.fit.i.2 <- plot(i, fit = fit.i.2, color = "lightblue")
  p.fit.sex <- plot(fit.sex)
  p.i <- plot(i)
  p.i.14 <- plot(i.14)
  p.i.2 <- plot(i, color = "blue", alpha = .2)
  p.i.3 <- plot(i, fit = fit.i, color = "red")
  p.sex <- plot(i.sex)
  p.sex.2 <- plot(i.sex, fit = fit.sex)
  p.sex.3 <- plot(i.sex, fit = fit.sex, col_pal = rainbow)
  p.sex.4 <- plot(i.sex, fit = fit.sex,
                  color = c(male = "salmon3", female = "gold2"))
  p.isoweek <- plot(i.isoweek)
  p.isoweek.2 <- plot(i.isoweek, labels_iso_week = FALSE)

  vdiffr::expect_doppelganger("incidence fit", p.fit.i)
  vdiffr::expect_doppelganger("incidence plot with two fitting models", p.fit.i.2)
  vdiffr::expect_doppelganger("grouped incidence fit", p.fit.sex)
  vdiffr::expect_doppelganger("incidence plot with default interval", p.i)
  vdiffr::expect_doppelganger("incidence plot with interval of 14 days", p.i.14)
  vdiffr::expect_doppelganger("incidence plot with specified color and alpha", p.i.2)
  vdiffr::expect_doppelganger("incidence plot with interval of 3 days, fit and specified color", p.i.3)
  vdiffr::expect_doppelganger("grouped incidence plot", p.sex)
  vdiffr::expect_doppelganger("grouped incidence plot with fit", p.sex.2)
  vdiffr::expect_doppelganger("grouped incidence plot with color palette", p.sex.3)
  vdiffr::expect_doppelganger("grouped incidence plot with specified color", p.sex.4)
  vdiffr::expect_doppelganger("incidence plot with isoweek labels", p.isoweek)
  vdiffr::expect_doppelganger("incidence plot without isoweek labels", p.isoweek.2)

  ## errors
  expect_error(plot(i, fit = "tamere"),
               "Fit must be a 'incidence_fit' object, or a list of these")
  expect_error(plot(i, fit = list(fit.i, "tamere")),
               "The 2-th item in 'fit' is not an 'incidence_fit' object, but a character")
})
