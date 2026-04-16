Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C633612D5
	for <audit@vger.kernel.org>; Thu, 16 Apr 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371632; cv=none; b=i0kLUdaUpiwXx4qzY6ErO0zo7VpSUVf64Auu5Z4BKAmzYVS5tDgBntqKmfWyIulREJtVzntxTt7Q3zRjFYYznB5sJwlKbZid21imy0+y75lPx3kuhbFLAVQPl4d266kqTIRxRnyiYFmZDZMo3Jd4YIAjyh7J+0iaDXeTGLjmqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371632; c=relaxed/simple;
	bh=tE6GE/me2jD3TAtNdDyLYJzZbg16wiqVPn0/Th0rqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9ci12Be3Zhyioh5kso7PAbOrhPpeVwQ7FdUyJ06DLjYmTwN8aEyDd51zeU74QuJYx/eQ/2b/k6KXfNszpKR8+XqUcnxWxySoSiQTgIIpVvdRzqRvCRvruE31vgvFS2bYyFl/MSxeW8fylovK7wK6BdsqLKdQ0g0zolPkVNT6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOKl6CnU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOKl6CnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776371629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWrUsdbVzZ/ojlrwHQmxnA3t0dos47yqLAWWqKAJGFI=;
	b=fOKl6CnUYElicAuVeLtrCeVirFyAllyjX+x1IyesFcVtam+3cOQO9k/1fIFEW+NC3NXUdN
	9CP2ajBQ4cdGjcCzFV3LgUhQqadoDFrsYtjC3kU0w6Z6DC7o/bXQaJLdZGh1bgM2eTliqQ
	DwcLUjL8R22N/coCVVHPM4KGKfVSrck=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-1qJctB2oMMK58ANMPCZc3A-1; Thu,
 16 Apr 2026 16:33:46 -0400
X-MC-Unique: 1qJctB2oMMK58ANMPCZc3A-1
X-Mimecast-MFC-AGG-ID: 1qJctB2oMMK58ANMPCZc3A_1776371625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24DDB1800367;
	Thu, 16 Apr 2026 20:33:45 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.65.66])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21572180047F;
	Thu, 16 Apr 2026 20:33:43 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, eparis@redhat.com
Subject: Re: [PATCH] audit: add backlog high water mark metric
Date: Thu, 16 Apr 2026 16:33:42 -0400
Message-ID: <2620823.XAFRqVoOGU@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
References: <20260323150700.614139-1-rrobaina@redhat.com>
 <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
 <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: EL_FZ_U6aLZAzseHGopSh1mAMUfMoXCHlWLCbCAQVVM_1776371625
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, April 15, 2026 11:21:52=E2=80=AFAM Eastern Daylight Time Paul=
 Moore=20
wrote:
> On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redhat.com=
> wrote:
> > > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Time Pa=
ul Moore=20
wrote:
> > > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina
> > > > <rrobaina@redhat.com>
> > >=20
> > > wrote:
> > ...
> >=20
> > > ... compliance-driven systems that must use a finite backlog limit fo=
r
> > > memory safety but cannot tolerate dropped events ...>=20
> > You must pick one of those two requirements, or at the very least
> > prioritize them; it is simply impossible to both limit the backlog
> > queue and require zero dropped events.
>=20
> To be perfectly honest, it's also impossible to require zero dropped
> events.  Even in the most extreme configurations where the admin
> decides to panic the system, that only happens once the system reaches
> the point where it is dropping events.  We try *really* hard to not
> drop events, but it is always going to be a possibility.

You're helping make the point.  Those administrators have decided reliable=
=20
auditing is more important than system availability. backlog_max_depth give=
s=20
them the one thing they currently lack: advance warning. If the high-water=
=20
mark is consistently approaching the backlog limit, they have actionable=20
information to raise the limit, reduce audit rule coverage, or address the=
=20
underlying load - before the system goes down. These are exactly the users=
=20
who would benefit the most from this metric.

-Steve


