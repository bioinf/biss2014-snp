import dadi

# Parse the data file to generate the data dictionary
data = dadi.Misc.make_data_dict('polar_bear.pooled.snp.cut')

# Extract the spectrum for ['YRI','CEU'] from that dictionary, with both
# projected down to 20 samples per population.
fs = dadi.Spectrum.from_data_dict(data, ['WG','EG'], [12,6])
folded = dadi.Spectrum.from_data_dict(data, ['WG','EG'], [12,6], polarized=False)

# data_brown = dadi.Misc.make_data_dict('brown_bear.pooled.snp')
# fs_brown = dadi.Spectrum.from_data_dict(data, ['ABC','RF'], [6,1])

# import pylab
# dadi.Plotting.plot_single_2d_sfs(fs_brown, vmin=0.1)
# pylab.show()


# def bear(params, ns, pts):

#     Ta, nua, Td, Tc1, Tc2, nu1A, nu2A, nu1B, nu2B, m12, m21 = params

#     xx = yy = dadi.Numerics.default_grid(pts)

#     phi = dadi.PhiManip.phi_1D(xx)
#     phi = dadi.Integration.one_pop(phi, xx, T = Ta + Tc2 + Td, nu = nua)
#     phi = dadi.PhiManip.phi_1D_to_2D(xx, phi)
#     phi = dadi.Integration.two_pops(phi, xx, Tc2 + Td, nu1 = nu1A, nu2 = nu2A, m12 = m12, m21 = m21)
#     phi = dadi.Integration.two_pops(phi, xx, Tc1, nu1 = nu1B, nu2 = nu2B, m12 = m12, m21 = m21)
#     phi = dadi.Integration.two_pops(phi, xx, Tc2, nu1 = nu1B, nu2 = nu2B, m12 = m12, m21 = m21)

#     fs = dadi.Spectrum.from_phi(phi, ns, (xx, yy))

#     return fs

def bear((TAf, nuAf, TB, nu_1, nu_2), (n1,n2), pts):
    xx = dadi.Numerics . default_grid (pts)

    phi = dadi.PhiManip . phi_1D(xx)
    phi = dadi.Integration . one_pop (phi, xx, TAf, nu = nuAf)
    phi = dadi.PhiManip . phi_1D_to_2D(xx, phi)
    phi = dadi.Integration . two_pops(phi, xx, TB, nu1 = nu_1, nu2 = nu_2)
    fs = dadi.Spectrum . from_phi(phi,(n1,n2), (xx,xx))
    return fs

extrap_func = dadi.Numerics.make_extrap_log_func(bear)

params = (14100000, 1, 2300000, 1, 1) 
# params = (1,2,3,4,5) 
ns = (12, 6)
pts = 100

# params = (2000000, 0.1, 1000000, 0.4,0.5) 
# ns = (12, 6)
# pts = 10

bear_model = extrap_func(params, ns, pts)
ll = dadi.Inference.ll(bear_model, folded)
# ll = dadi.Inference.ll_multinomial(bears(params, ns, pts), data)
# theta0 = dadi . Inference . optimal_sfs_scaling(bear_model, folded)

print(ll)
# print(theta0)
