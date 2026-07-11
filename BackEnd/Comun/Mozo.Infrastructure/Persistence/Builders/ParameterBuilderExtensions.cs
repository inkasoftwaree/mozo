using Mozo.Infrastructure.Persistence.Abstractions;
using System.Data;

namespace Mozo.Infrastructure.Persistence.Builders;

public static class ParameterBuilderExtensions
{

    public static IParameterBuilder AddEmpresa(
       this IParameterBuilder builder,
       long coEmpresa) => builder.Add("CoEmpresa", coEmpresa, DbType.Int32);


    public static IParameterBuilder AddUserCreate(
        this IParameterBuilder builder,
        long userId) => builder.Add("CoUsuCre", userId, DbType.Int32);


    public static IParameterBuilder AddUserUpdate(
        this IParameterBuilder builder,
        long userId) => builder.Add("CoUsuMod", userId, DbType.Int32);


    public static IParameterBuilder AddUserDelete(
        this IParameterBuilder builder,
        long userId) => builder.Add("CoUsuEli", userId, DbType.Int32);

}